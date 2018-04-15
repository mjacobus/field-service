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
            <a href={ routes.publishers.index() }>{ t.publishers }</a>
          </Col>
          <Col xs={12} md={3}>
            <a href={ routes.householders.search() }>{ t.search }</a>
          </Col>
          <Col xs={12} md={3}>
            <a href={ routes.main.profile() }>{ t.profile }</a> | <a href={ routes.main.logout() }>{ t.logout }</a>
          </Col>
        </Row>
      </Grid>
    </div>
  );
};
