import React, { Component } from 'react';
import { Redirect, withRouter } from 'react-router-dom';
import { Col, Row } from 'react-bootstrap';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import LoaderOrContent from '../../components/loader-or-content';
import { Form, RadioButtons, DateInput } from '../../components/form';

import styles from './form.css';

const formValue = (key, values) => {
  let value = values[key];

  if (!value) {
    return '';
  }

  return value;
};

const renderForm = ({ onSubmit, onChange, posting, values = {}, errors = {}}) => {
  const buttons = [
    { type: "submit", disabled: posting, label: t.save },
    { linkTo: routes.territories.index(), label: t.back },
  ];

  const renderInputText = (name, otherOptions = {}) => (
    <InputText label={ t[name] }
      name={ name }
      value={ formValue(name, values) }
      onChange={ onChange }
      errors={ errors[name] }
      {...otherOptions}
    />
  );

  return <Form onSubmit={ onSubmit } buttons={ buttons }>
    <Row>
      <Col xs={12} sm={8}>{ renderInputText('streetName') }</Col>
      <Col xs={12} sm={4}>{ renderInputText('houseNumber') }</Col>
    </Row>
    <Row>
      <Col xs={12} sm={8}>{ renderInputText('name') }</Col>
      <Col xs={12} sm={4}>
        <RadioButtons label={ t.speakTheLanguage } options={ [['1', t.yes ], [ '0', t.no ]] }
          name="speakTheLanguage" onChange={ onChange } value={ formValue('speakTheLanguage', values) ? '1' : '0' } defaultValue={1}
          className={ styles.yesNo }
        />
      </Col>
    </Row>
    <Row>
      <Col xs={12} sm={4} smOffset={8}>
        {/* TODO: Set proper date as initial value for editing */}
        <DateInput name="doNotVisitDate" label={ t.doNotVisitDate } onChange={ onChange } value={ formValue('doNotVisitDate', values) }/>
      </Col>
    </Row>
  </Form>;
};

class HouseholderForm extends Component {
  constructor(props) {
    super(props);
    this.onSubmit = this.onSubmit.bind(this);
    this.onChange = this.onChange.bind(this);
    this.values = {};

    this.territorySlug = this.props.match.params.territorySlug;
    this.householderId = this.props.match.params.id;
  }

  componentWillUnmount() {
    this.props.onUnmount(this.territorySlug);
  }

  componentWillMount() {
    this.props.fetchHouseholder(this.territorySlug, this.householderId);
  }

  onChange(event) {
    this.values[event.target.name] = event.target.value;
  }

  onSubmit(e) {
    e.preventDefault();
    this.props.saveTerritory(this.territorySlug, this.values);
  }

  render() {
    const loading = false;
    const onSubmit = this.onSubmit;
    const onChange = this.onChange.bind(this);
    const values = this.props.values || this.values;
    const errors = this.props.errors;
    const props = { onChange, onSubmit, values, errors };

    if (this.props.persisted) {
      const territoryUrl = routes.territories.show(this.territorySlug);
      return <Redirect to={ territoryUrl } />
    }

    return <LoaderOrContent loading={ loading }>{ renderForm(props) }</LoaderOrContent>
  }
}

export default withRouter(HouseholderForm);
