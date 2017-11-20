import React, { Component } from 'react';

import t from '../../../translations';

import InputText from '../../components/input-text';
import Button from '../../components/button';

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
    territory: {
      name: '',
      city: '',
      description: '',
    },
    errors: {},
  }

  constructor(props) {
    super(props);
    this.setAttribute = this.setAttribute.bind(this);
    this.onSubmit = this.onSubmit.bind(this);
    this.state = { territory: {} };
    this.slug = this.props.match.params.slug;
  }

  componentWillMount() {
    this.props.fetchTerritory(this.slug);
  }

  onSubmit(event) {
    event.preventDefault();
    this.props.submitValues(this.state.territory);
  }

  setAttribute(attribute, value) {
    const newTerritory = Object.assign({}, this.state.territory, { [attribute] : value });
    this.setState({ territory: newTerritory })
  }

  render() {
    const onAttributeChange = this.setAttribute;
    const territory = this.props.territory;
    const errors = this.props.errors;

    return <TerritoryForm onSubmit={ this.onSubmit } territory={ territory } onAttributeChange={ onAttributeChange } errors={errors} />
  }
}
