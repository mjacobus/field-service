import React, { Component } from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import Button from 'react-bootstrap/lib/Button';
import style from './list.css';
import LoaderOrContent from '../../components/loader-or-content';

class SearchForm extends Component {
  static defaultProps = { fetchTerritories: ()  => {}, loading: true };

  render() {
    return (
      <Button onClick={ () => this.handleClick() }>Refresh</Button>
    );
  }

  handleClick() {
    this.props.fetchTerritories();
  }
}

class TerritoryList extends Component {
  static defaultProps = { territories: [], loading: true };

  renderTerritoryList(territories) {
    const props = this.props;

    return (
      <div>
        <SearchForm fetchTerritories={this.props.onInitialize} />

        <ul className={ style.territoryList }>
          { territories.map((territory) => (this.renderTerritory(territory))) }
        </ul>
      </div>
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

  componentWillMount() {
    this.props.onInitialize();
  }

  render() {
    return (
      <Grid>
        <Row>
          <Col xs={12} md={2}>
            <Button href="/frontend/somethingels">Google</Button>
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
