import React from 'react';
import styles from './label.css';

export default ({ children }) => {
  return (<label className={styles.label}>{ children }</label>);
};
