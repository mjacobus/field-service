import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Item from '../../components/property-value-label';
import Separator from '../../components/separator';
import Date from '../../components/date';
import DeleteHouseholderButton from '../../pages/shared/householder-delete-button';

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
          <Row>
            <Col xs={12} sm={7}>
              <Item description={ t.address } separator={ false }>{ householderEditLink(householder.address) }</Item>
            </Col>
            <Col xs={12} sm={5}>
              <Item description={ t.name } separator={ false }>{ householderEditLink(householder.name) }</Item>
            </Col>
          </Row>
        </Col>
        <Col xs={4}>
          <Row>
            <Col xs={12} sm={6}>
              {
                householder.doNotVisitDate &&
                <Item className={ styles.floatRight } description={ t.doNotVisit } separator={ false }><Date>{ householder.doNotVisitDate }</Date></Item>
              }
            </Col>
            <Col xs={12} sm={6}>
              <DeleteHouseholderButton householder={ householder } onDelete={ onDelete } className={ styles.deleteButton } />
            </Col>
          </Row>
        </Col>
      </Row>

      { separator && <Separator /> }
    </div>
  );
};
