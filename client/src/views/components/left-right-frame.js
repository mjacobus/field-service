import React from 'react';
import {Grid, Row, Col} from 'react-bootstrap';

export default ({ leftComponent, rightComponent }) => {
  return (
    <Grid>
      <Row>
        <Col xs={12} md={3}>{ leftComponent }</Col>
        <Col xs={12} md={9}>{ rightComponent }</Col>
      </Row>
    </Grid>
  );
};
