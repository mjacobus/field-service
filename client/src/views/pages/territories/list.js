import React, { Component } from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import style from './list.css';
import LoaderOrContent from '../../components/loader-or-content';
import AsyncButton from '../../components/async-button';
import PublishersSelector from '../../components/publishers-selector';

class SearchForm extends Component {
  static defaultProps = { fetchTerritories: ()  => {}, loading: true };

  constructor(props) {
    super(props);
    this.setPublisherIds = this.setPublisherIds.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleSubmit() {
    this.props.fetchTerritories({
      assigned_to_ids: this.publisherIds
    });
  }

  setPublisherIds(values) {
    this.publisherIds = values;
  }

  render() {
    return (
      <fieldset>
        <PublishersSelector
          onCollectionChange={ this.setPublisherIds }
          multiple={ true }
        />

        <AsyncButton
          asyncAction={ this.handleSubmit }
          loading={ this.props.loading }
          loadingText="Loading..." >Search</AsyncButton>
      </fieldset>
    );
  }
}

class TerritoryList extends Component {
  static defaultProps = { territories: [], loading: true };

  componentWillMount() {
    this.props.onInitialize();
  }

  renderTerritoryList(territories) {
    if (territories.length == 0) {
      return <p>No territories found</p>;
    }
    return (
      <ul className={ style.territoryList }>
        { territories.map((territory) => (this.renderTerritory(territory))) }
      </ul>
    );
  }

  renderTerritory(territory) {
    return (
      <li key={territory.slug} className={ style.itemRow }>
        <Row>
          <Col xs={12} md={2}>
            <span className={ style.territoryName }>
              { territory.name }
            </span>
            <span className={ style.householderCount }>
              ({ territory.householders.length })
            </span>
          </Col>

          <Col xs={12} md={6}>
            <span className={ style.territoryCity }>
              { territory.city }
            </span>
            <span className={ style.territoryDescription }>
              { territory.description }
            </span>
          </Col>

          <Col xs={12} md={4}>
            { territory.currentAssignment &&
                <Row>
                  <Col xs={7} className={ style.assigneeName }>{ territory.currentAssignment.assigneeName }</Col>
                  <Col xs={5} className={ style.returnDate }>{ territory.currentAssignment.returnDate }</Col>
                </Row>
            }
          </Col>
        </Row>
      </li>
    );
  }

  render() {
    return (
      <Grid>
        <Row>
          <Col xs={12} md={2}>
            <SearchForm fetchTerritories={this.props.onInitialize} loading={ this.props.loading } />
          </Col>

          <Col xs={12} md={10}>
            <LoaderOrContent loading={ this.props.loading }>
              { this.renderTerritoryList(this.props.territories) }
            </LoaderOrContent>
          </Col>
        </Row>
      </Grid>
    );
  }
}

export default TerritoryList;
