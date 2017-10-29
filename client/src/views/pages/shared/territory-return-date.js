import React from 'react';

import styles from './territory-return-date.css';

const pendingReturn = (date) => {
  return <div className={ styles.pendingReturn }>{ date }</div>;
}

const futureReturn = (date) => {
  return <div>{ date }</div>;
}

export default ({ assignment }) => {
  return (assignment.pendingReturn ? pendingReturn(assignment.returnDate) : futureReturn(assignment.returnDate));
};
