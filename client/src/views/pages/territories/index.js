import React, { Component } from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import Button from 'react-bootstrap/lib/Button';
import style from './index.css';

class TerritoryList extends Component {
  static defaultProps = { territories: [] };

  renderTerritoryList(territories) {
    return <ul className={ style.territoryList }>
      {
        territories.map((territory) => (this.renderTerritory(territory)))
      }
      </ul>;
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
            { territory.assignee &&
                <Row>
                  <Col xs={7} className={ style.assigneeName }>{ territory.assignee.name }</Col>
                  <Col xs={5} className={ style.returnDate }>{ territory.assignee.returnDate }</Col>
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
            {this.renderTerritoryList(this.props.territories)}
          </Col>
        </Row>
      </Grid>
    );
  }
}

export default TerritoryList;
