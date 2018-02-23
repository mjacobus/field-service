import React, { Component } from 'react';
import { Redirect, withRouter } from 'react-router-dom';

import t from '../../../translations';
import routes from '../../../app-routes';

import InputText from '../../components/input-text';
import Button from '../../components/button';
import LoaderOrContent from '../../components/loader-or-content';
import PublishersSelect from '../../pages/shared/publishers-selector';
import Block from '../../../views/components/input-block';
import Label from '../../../views/components/label';


import globalStyle from '../../../global.css';

const classNames = [
  globalStyle.wide,
  globalStyle.spaceAbove,
];

const filterInput = (value) => {
  return value || '';
};

const TerritoryForm = withRouter(({ onSubmit, posting, territory = {}, onAttributeChange, errors, history }) => {
  const setValue = (event) => {
    event.preventDefault();
    return onAttributeChange(event.target.name, event.target.value);
  }

  const setResponsibleId = (selectedValues) => {
    return onAttributeChange('responsible_id', selectedValues.pop() || null);
  };

  return <form onSubmit={ onSubmit }>
    <InputText label={ t.name } name="name" value={ filterInput(territory.name) } onChange={ setValue } errors={ errors.name }/>
    <InputText label={ t.city } name="city" value={ filterInput(territory.city) } onChange={ setValue } errors={ errors.city }/>
    <InputText label={ t.description } name="description" value={ filterInput(territory.description) } onChange={ setValue } errors={ errors.description } />

    <Block>
      <Label>{ t.responsible }</Label>
      <br />
      <PublishersSelect overseers={ true }  name="responsible_id" value={ filterInput(territory.responsible_id) } onCollectionChange={ setResponsibleId } errors={ errors.responsible_id } />
    </Block>

    <Button type="submit" disabled={ posting } className={ classNames }>{ t.save }</Button>
    <Button type="submit" className={ classNames } onClick={ () => history.push(routes.territories.index()) }>{ t.back }</Button>
  </form>
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
    values.responsible_id = values.responsible_id || (values.responsible || { id: null }).id
    const { slug } = this;

    return {
      slug: slug,
      name: values.name,
      city: values.city,
      description: values.description,
      responsible_id: values.responsible_id,
    }
  }

  setAttribute(attribute, value) {
    console.log(attribute, value);
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

    return <LoaderOrContent loading={ this.props.loading }>
      { <TerritoryForm {...props} /> }
    </LoaderOrContent>
  }
}
