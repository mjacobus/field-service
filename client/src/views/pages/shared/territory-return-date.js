import React from 'react';

import Date from '../../components/date';

import styles from './territory-return-date.css';

const pendingReturn = (date) => {
  return <Date className={ styles.pendingReturn }>{ date }</Date>;
}

const futureReturn = (date) => {
  return <Date>{ date }</Date>;
}

export default ({ assignment }) => {
  return (assignment.pendingReturn ? pendingReturn(assignment.returnDate) : futureReturn(assignment.returnDate));
};
