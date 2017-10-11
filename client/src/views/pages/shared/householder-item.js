import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Item from '../../components/property-value-label';
import Separator from '../../components/separator';

import styles from './householder-item.css';

export default ({ householder, separator = true }) => {
  let classNames = [styles.housholderItemContainer];

  if (!householder.visit) {
    classNames.push(styles.doNotVisit);
  }

  return (
    <div className={classNames.join(' ')}>
      <Row>
        <Col xs={12} md={4}>
          <Item description='Address' separator={ false }>{ householder.address }</Item>
        </Col>
        <Col xs={12} md={4}>
          <Item description='Name' separator={ false }>{ householder.name }</Item>
        </Col>
        <Col xs={12} md={4}>
          { householder.doNotVisitDate && <Item description='Do Not Visit' separator={ false }>{ householder.doNotVisitDate }</Item> }
        </Col>
      </Row>

      { separator && <Separator /> }
    </div>
  );
};
