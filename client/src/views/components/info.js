import React from 'react';
import {Row, Col} from 'react-bootstrap';
import Label from './label';
import styles from './info.css';

export default function({description, children}) {
  const name = description;
  const value = children;

  return (
    <div className={styles.info}>
      <Row>
        <Col xs={12} md={4}><Label>{ name }:</Label></Col>
        <Col xs={12} md={8}><span>{ value }</span></Col>
      </Row>
    </div>
  );
};
