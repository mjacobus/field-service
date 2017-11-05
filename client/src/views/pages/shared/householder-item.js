import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Item from '../../components/property-value-label';
import Separator from '../../components/separator';
import Date from '../../components/date';
import DeleteHouseholderButton from '../../components/householder-delete-button';

import t from '../../../translations';

import styles from './householder-item.css';

const noop = () => {
  console.log('No on delete provided for Item')
};

export default ({ householder, onDelete = noop, separator = true }) => {
  let classNames = [styles.housholderItemContainer];

  if (!householder.visit) {
    classNames.push(styles.doNotVisit);
  }

  const householderEditLink = (content) => {
    return <a href={ householder.links.edit }>{content}</a>;
  };

  return (
    <div className={classNames.join(' ')}>
      <Row>
        <Col xs={8}>
            <Col xs={12} md={7}>
              <Item description={ t.address } separator={ false }>{ householderEditLink(householder.address) }</Item>
            </Col>
            <Col xs={12} md={5}>
              <Item description={ t.name } separator={ false }>{ householderEditLink(householder.name) }</Item>
            </Col>
        </Col>
        <Col xs={4}>
          <Col xs={12} md={6}>
            {
              householder.doNotVisitDate &&
              <Item description={ t.doNotVisit } separator={ false }><Date>{ householder.doNotVisitDate }</Date></Item>
            }
          </Col>
          <Col xs={12} md={6}>
            <DeleteHouseholderButton householder={ householder } onDelete={ onDelete } className={ styles.deleteButton } />
          </Col>
        </Col>
      </Row>

      { separator && <Separator /> }
    </div>
  );
};
