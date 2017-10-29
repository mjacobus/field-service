import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Item from '../../components/property-value-label';
import Separator from '../../components/separator';
import Icon from '../../components/icon';

import t from '../../../translations';

import styles from './territory-assignment-item.css';

const returnDateText = (item) => {
  if (item.returned) {
    return t.returnedAt;
  }

  return t.dueDate;
};

const returnDate = (item) => {
  if (item.returned) {
    return item.returnedAt;
  }

  return item.returnDate;
};

const classNameForDate = (item) => {
  if (item.pendingReturn) {
    return styles.pendingReturn;
  }

  return null;
};

const iconsForItem = (item) => {
  let icons = [];

  if (item.returned) {
    if (item.complete) {
      icons.push(['check', t.territoryCompletelyWorked]);
    } else {
      icons.push(['fail', t.territoryNotCompletelyWorked]);
    }
  }

  if (!item.returned) {
    icons.push(['inProgress', t.territoryWorkInProgress]);
  }

  return <div> { icons.map((config, key) => <Icon key={key} type={config[0]} title={ config[1] } />) } </div>;
};

export default ({ item, children, separator = true }) => {
  return (
    <div>
      <Row>
        <Col xs={12} md={3}> { children } </Col>
        <Col xs={12} md={3}>
          <Item description={ t.assignedAt } separator={ false }>{ item.assignedAt }</Item>
        </Col>
        <Col xs={12} md={3}>
          <Item className={ classNameForDate(item) } description={ returnDateText(item) } separator={ false }>{ returnDate(item) }</Item>
        </Col>
        <Col xs={12} md={3}>{ iconsForItem(item) } </Col>
      </Row>
      { separator && <Separator />}
    </div>
  );
};
