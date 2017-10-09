import React, { Component } from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import Button from 'react-bootstrap/lib/Button';
import style from './index.css';

const testData = [
  {
    slug: 't1',
    name: 'T1',
    householders: [1,2],
    city: 'Hamburg',
    description: 'some description',
    assignee: {
      name: 'Marcelo',
      returnDate: '2017-12-01'
    }
  },
  {
    slug: 't2',
    name: 'T2',
    householders: [1,2,3],
    city: 'Berlin',
    description: null,
    assignee: null
  }
]

class TerritoryList extends Component {
  renderTerritoryList(territories) {
    return <ul className="territoryList">
      {
        territories.map((territory) => (this.renderTerritory(territory)))
      }
      </ul>;
  }

  renderTerritory(territory) {
    return (
      <li className="territoryItem">
        <Row>
          <Col xs={12} md={2}>
            <span className="territoryName">
              { territory.name }
            </span>
            <span className="territoryHouseholderCount">
              ({ territory.householders.length })
            </span>
          </Col>

          <Col xs={12} md={6}>
            <span className="territoryDescription">
              { territory.description }
            </span>
            <span className="territoryCity">
              { territory.city }
            </span>
          </Col>

          <Col xs={12} md={4}>
            { territory.assignee &&
                <Row>
                  <Col xs={6} className="assigneeName">{ territory.assignee.name }</Col>
                  <Col xs={6} className="assignmentReturnDate">{ territory.assignee.returnDate }</Col>
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
          <Col xs={12} md={4}>
            <Button href="/frontend/somethingels">Google</Button>
          </Col>

          <Col xs={12} md={8}>
            {this.renderTerritoryList(testData)}
          </Col>
        </Row>
      </Grid>
    );
  }
}

export default TerritoryList;
