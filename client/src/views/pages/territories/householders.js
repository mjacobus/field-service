import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Separator from '../../components/separator';
import NewHouseholderButton from './button-new-householder';
import HouseholderItem from '../shared/householder-item';
import styles from '../../../global.css';

export default function ({ territory, onDelete }) {
  const header = <Row>
    <Col xs= { 12 }>
      <NewHouseholderButton territory={territory} className={ styles.floatRight } />
      <NewHouseholderButton territory={territory} className={ styles.floatRight } label='Legacy add' legacyUrl={ true } />
    </Col>
    <Col xs= { 12 }> <Separator /> </Col>
  </Row>;


  const last = territory.householders.length - 1;

  const list = territory.householders.map((householder, index) => {
    const separator = index !== last;
    return <HouseholderItem key={ householder.id } householder={ householder } separator={ separator } onDelete={ onDelete }/>
  });

  return <div> { header } { list } </div>
};
