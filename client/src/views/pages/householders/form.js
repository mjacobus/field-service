import React, { Component } from 'react';
import { Redirect, withRouter } from 'react-router-dom';
import { Col, Row } from 'react-bootstrap';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import LoaderOrContent from '../../components/loader-or-content';
import { Form, RadioButtons, DateInput } from '../../components/form';

import styles from './form.css';

const renderForm = ({ onSubmit, onChange, posting, householder = {}, errors = {}}) => {
  const buttons = [
    { type: "submit", disabled: posting, label: t.save },
    { linkTo: routes.territories.index(), label: t.back },
  ];

  const renderInputText = (name, otherOptions = {}) => (
    <InputText label={ t[name] }
      name={ name }
      value={ householder[name] }
      onChange={ onChange }
      errors={ errors[name] }
      {...otherOptions}
    />
  );

  return <Form onSubmit={ onSubmit } buttons={ buttons }>
    <DateInput name="myDate" label={ t.doNotVisitDate } onChange={ onChange }/>
    <Row>
      <Col xs={12} sm={8}>{ renderInputText('streetName') }</Col>
      <Col xs={12} sm={4}>{ renderInputText('houseNumber') }</Col>
    </Row>
    <Row>
      <Col xs={12} sm={8}>{ renderInputText('name') }</Col>
      <Col xs={12} sm={4}>
        <RadioButtons label={ t.speakTheLanguage } options={ [[1, t.yes ], [ 0, t.no ]] }
          name="speakTheLanguage" onChange={ onChange } defaultValue={1}
          className={ styles.yesNo }
        />
      </Col>
    </Row>
    <Row>
      <Col xs={12} sm={4} smOffset={8}>{ renderInputText('doNotVisitDate', { placeholder: 'Date YYYY-MM-DD' }) } </Col>
    </Row>
  </Form>;
};

class HouseholderForm extends Component {
  state = {}

  constructor(props) {
    super(props);
    this.onSubmit = this.onSubmit.bind(this);
    this.onChange = this.onChange.bind(this);
    this.values = {};

    this.territorySlug = this.props.match.params.territorySlug;
  }

  componentWillUnmount() {
    this.props.onUnmount();
  }

  onChange(event) {
    this.values[event.target.name] = event.target.value;
    console.log(this.values);
  }

  onSubmit(e) {
    e.preventDefault();
    this.props.saveTerritory(this.territorySlug, this.values);
  }

  render() {
    const loading = false;
    const onSubmit = this.onSubmit;
    const onChange = this.onChange.bind(this);
    const householder = this.values;
    const errors = this.props.errors;
    const props = { onChange, onSubmit, householder, errors };

    if (this.props.persisted) {
      const territoryUrl = routes.territories.show(this.territorySlug);
      return <Redirect to={ territoryUrl } />
    }

    return <LoaderOrContent loading={ loading }>{ renderForm(props) }</LoaderOrContent>
  }
}

export default withRouter(HouseholderForm);
