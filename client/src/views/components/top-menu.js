import React from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import {Link} from 'react-router-dom';
import style from './top-menu.css';
import routes from '../../app-routes';

export default () => {
  return (
    <div className={style.topMenu}>
      <Grid>
        <Row>
          <Col xs={12} md={3}>
            <Link to="/app/territories">Territories</Link>
          </Col>
          <Col xs={12} md={3}>
            <Link to="/app/publishers">Publishers</Link>
          </Col>
          <Col xs={12} md={3}>
            <Link to="/app/territory_assignments">Territories</Link>
          </Col>
          <Col xs={12} md={3}>
            <a href={ routes.territories.legacyList() }>Legacy</a>
          </Col>
        </Row>
      </Grid>
    </div>
  );
};
