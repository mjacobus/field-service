import React, { Component } from 'react';
import { Redirect } from 'react-router-dom';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import Button from '../../components/button';
import LoaderOrContent from '../../components/loader-or-content';


import globalStyle from '../../../global.css';

const classNames = [
  globalStyle.wide,
  globalStyle.spaceAbove,
];

const filterInput = (value) => {
  return value || '';
};

const TerritoryForm = ({ onSubmit, territory = {}, onAttributeChange, errors }) => {
  const setValue = (attributeName) => {
    return (event) => {
      event.preventDefault();
      return onAttributeChange(attributeName, event.target.value);
    }
  }

  return <form onSubmit={ onSubmit }>
    <InputText label={ t.name } name="name" value={ filterInput(territory.name) } onChange={ setValue("name") } errors={ errors.name }/>
    <InputText label={ t.city } name="city" value={ filterInput(territory.city) } onChange={ setValue("city") } errors={ errors.city }/>
    <InputText label={ t.description } name="description" value={ filterInput(territory.description) } onChange={ setValue("description") } errors={ errors.description } />

    <Button type="submit" className={ classNames }>{ t.save }</Button>
  </form>
};

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

  onSubmit(event) {
    event.preventDefault();

    if (!this.changed) {
      console.log('nothing changed');
      return;
    }

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

    return <LoaderOrContent loading={ this.props.loading }>
      { <TerritoryForm onSubmit={ this.onSubmit } territory={ territory } onAttributeChange={ onAttributeChange } errors={errors} /> }
    </LoaderOrContent>
  }
}
