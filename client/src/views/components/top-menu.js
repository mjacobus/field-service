import React from 'react';
import {Grid, Row, Col} from 'react-bootstrap';
import {Link} from 'react-router-dom';
import style from './top-menu.css';
import routes from '../../app-routes';

import t from '../../translations';

export default () => {
  return (
    <div className={style.topMenu}>
      <Grid>
        <Row>
          <Col xs={12} md={3}>
            <Link to="/app/territories">{ t.territories }</Link>
          </Col>
          <Col xs={12} md={3}>
            <Link to="/app/publishers">{ t.publishers }</Link>
          </Col>
          <Col xs={12} md={3}>
            <Link to="/app/territory_assignments"> { t.territoryAssignments }</Link>
          </Col>
          <Col xs={12} md={3}>
            <a href={ routes.territories.legacyList() }>Legacy</a>
          </Col>
        </Row>
      </Grid>
    </div>
  );
};
