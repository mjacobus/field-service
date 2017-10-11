import React, {Component} from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import style from './top-menu.css';

export default class TopMenu extends Component {
  render() {
    return (
      <div className={style.topMenu}>
        <Grid>
          <Row>
            <Col xs={12} md={3}>
              <a href="/territories">Territories</a>
            </Col>
            <Col xs={12} md={3}>
              <a href="/publishers">Publishers</a>
            </Col>
            <Col xs={12} md={3}>
              <a href="/territory_assignments">Territories</a>
            </Col>
            <Col xs={12} md={3}>
              <a href="/sign_out">Sign out</a>
            </Col>
          </Row>
        </Grid>
      </div>
    );
  }
}
