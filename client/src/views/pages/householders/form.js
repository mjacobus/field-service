import React, { Component } from 'react';
import { /* Redirect ,*/ withRouter } from 'react-router-dom';
import { Col, Row } from 'react-bootstrap';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import LoaderOrContent from '../../components/loader-or-content';
import { Form } from '../../components/form';

const renderForm = withRouter(({ onSubmit, posting, householder = {}, onAttributeChange, errors = {}, history }) => {
  const setValue = (event) => {
    event.preventDefault();
    return onAttributeChange(event.target.name, event.target.value);
  }

  const buttons = [
    { type: "submit", disabled: posting, label: t.save },
    { linkTo: routes.territories.index(), label: t.back },
  ];

  return <Form onSubmit={ onSubmit } buttons={ buttons }>
    <Row>
      <Col xs={12} sm={8}>
        <InputText label={ t.streetName } name="streetName" value={ householder.streetName } onChange={ setValue } errors={ errors.streetName }/>
      </Col>
      <Col xs={12} sm={4}>
        <InputText label={ t.streetNumber } name="streetNumber" value={ householder.streetNumber } onChange={ setValue } errors={ errors.streetNumber }/>
      </Col>
    </Row>

    <Row>
      <Col xs={12} sm={8}>
        <InputText label={ t.name } name="name" value={ householder.name } onChange={ setValue } errors={ errors.name }/>
      </Col>
      <Col xs={12} sm={4}>
        <InputText label={ t.speakTheLanguage } name="speakTheLanguage" value={ householder.speakTheLanguage } onChange={ setValue } errors={ errors.speakTheLanguage }/>
      </Col>
    </Row>
    <Row>
      <Col xs={12} sm={4} smOffset={8}>
        <InputText label={ t.doNotVisitDate } name="doNotVisitDate" value={ householder.doNotVisitDate } onChange={ setValue } errors={ errors.doNotVisitDate }/>
      </Col>
    </Row>
  </Form>;
});

export default class HouseholderForm extends Component {
  render() {
    const props = { };
    const loading = false;
    return <LoaderOrContent loading={ loading }>{ renderForm(props) }</LoaderOrContent>
  }
}
