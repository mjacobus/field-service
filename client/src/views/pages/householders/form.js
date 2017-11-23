import React, { Component } from 'react';
import { Redirect, withRouter } from 'react-router-dom';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import LoaderOrContent from '../../components/loader-or-content';
import { Form } from '../../components/form';

const renderForm = withRouter(({ onSubmit, posting, territory = {}, onAttributeChange, errors, history }) => {
  const setValue = (event) => {
    event.preventDefault();
    return onAttributeChange(event.target.name, event.target.value);
  }

  const buttons = [
    { type: "submit", disabled: posting, label: t.save },
    { linkTo: routes.territories.index(), label: t.back },
  ];

  return <Form onSubmit={ onSubmit } buttons={ buttons }>
    <InputText label={ t.name } name="name" value={ null } onChange={ setValue } errors={ errors.name }/>
    <InputText label={ t.city } name="city" value={ territory.city } onChange={ setValue } errors={ errors.city }/>
    <InputText label={ t.description } name="description" value={ territory.description } onChange={ setValue } errors={ errors.description } />
  </Form>;
});

export default class TerritoryEdit extends Component {
  static defaultProps = {
    persisted: false,
    territory: {},
    errors: {},
  }

  constructor(props) {
    super(props);
    this.setAttribute = this.setAttribute.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.state = { territory: {} };
    this.slug = this.props.match.params.slug;
    this.changed = false;
  }

  componentWillMount() {
    this.props.fetchTerritory(this.slug);
  }

  componentWillUnmount() {
    this.props.resetPersisted();
  }

  onSubmit(event) {
    event.preventDefault();

    this.props.submitValues(this.slug, this.getValues());
  }

  getValues() {
    const values =  Object.assign({}, this.props.territory, this.state.territory);

    const { slug } = this;

    return {
      slug: slug,
      name: values.name,
      city: values.city,
      description: values.description,
    }
  }

  setAttribute(attribute, value) {
    const newTerritory = Object.assign({}, this.state.territory, { [attribute] : value });
    this.setState({ territory: newTerritory })
    this.changed = true;
  }

  render() {
    if (this.props.persisted) {
      return <Redirect to={ routes.territories.index() } />
    }

    const onAttributeChange = this.setAttribute;
    const territory = this.getValues();
    const errors = this.props.errors;
    const onSubmit = this.onSubmit;
    const posting = this.props.posting;
    const props = { territory, errors, onAttributeChange, onSubmit, posting };

    return <LoaderOrContent loading={ this.props.loading }>{ renderForm(props) }</LoaderOrContent>
  }
}

