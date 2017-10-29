import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Item from '../../components/property-value-label';
import Separator from '../../components/separator';
import Date from '../../components/date';

import t from '../../../translations';

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
          <Item description={ t.address } separator={ false }>{ householder.address }</Item>
        </Col>
        <Col xs={12} md={4}>
          <Item description={ t.name } separator={ false }>{ householder.name }</Item>
        </Col>
        <Col xs={12} md={4}>
          {
            householder.doNotVisitDate &&
            <Item description={ t.doNotVisit } separator={ false }><Date>{ householder.doNotVisitDate }</Date></Item>
          }
        </Col>
      </Row>

      { separator && <Separator /> }
    </div>
  );
};
