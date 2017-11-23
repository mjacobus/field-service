import React, { Component } from 'react';
import { Redirect, withRouter } from 'react-router-dom';
import { Col, Row } from 'react-bootstrap';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import LoaderOrContent from '../../components/loader-or-content';
import { Form } from '../../components/form';

const renderForm = ({ onSubmit, onChange, posting, householder = {}, errors = {}}) => {
  const buttons = [
    { type: "submit", disabled: posting, label: t.save },
    { linkTo: routes.territories.index(), label: t.back },
  ];

  const renderInputText = (name) => (
    <InputText label={ t[name] }
      name={ name }
      value={ householder[name] }
      onChange={ onChange }
      errors={ errors[name] }
    />
  );

  console.log('errors -> ', errors)
  return <Form onSubmit={ onSubmit } buttons={ buttons }>
    <Row>
      <Col xs={12} sm={8}>{ renderInputText('streetName') }</Col>
      <Col xs={12} sm={4}>{ renderInputText('houseNumber') }</Col>
    </Row>
    <Row>
      <Col xs={12} sm={8}>{ renderInputText('name') }</Col>
      <Col xs={12} sm={4}>{ renderInputText('speakTheLanguage') }</Col>
    </Row>
    <Row>
      <Col xs={12} sm={4} smOffset={8}>{ renderInputText('doNotVisitDate') } </Col>
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
