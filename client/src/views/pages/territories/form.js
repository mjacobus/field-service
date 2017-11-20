import React, { Component } from 'react';

import t from '../../../translations';

import InputText from '../../components/input-text';
import Button from '../../components/button';

import globalStyle from '../../../global.css';

const classNames = [
  globalStyle.wide,
  globalStyle.spaceAbove,
];

const TerritoryForm = ({ onSubmit, territory = {}, onAttributeChange, errors }) => {
  const setValue = (attributeName) => {
    return (event) => {
      event.preventDefault();
      return onAttributeChange(attributeName, event.target.value);
    }
  }

  return <form onSubmit={ onSubmit }>
    <InputText label={ t.name } name="name" value={ territory.name } onChange={ setValue("name") } errors={ errors.name }/>
    <InputText label={ t.city } name="city" value={ territory.city } onChange={ setValue("city") } errors={ errors.city }/>
    <InputText label={ t.description } name="description" value={territory.description} onChange={ setValue("description") } errors={ errors.description } />

    <Button type="submit" className={ classNames }>{ t.save }</Button>
  </form>
};

export default class TerritoryEdit extends Component {
  constructor(props) {
    super(props);
    this.setAttribute = this.setAttribute.bind(this);

    const territory = {
      name: 't1',
      city: 'city',
      description: 'city',
    };

    this.state = { territory, errors: [] };
    this.onSubmit = this.onSubmit.bind(this);
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
    const territory = this.state.territory;
    const errors = this.state.errors;

    return <TerritoryForm onSubmit={ this.onSubmit } territory={ territory } onAttributeChange={ onAttributeChange } errors={errors} />
  }
}
