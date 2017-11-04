import React from 'react';
import styles from './label.css';

export default ({ children, otherProps }) => {
  return (<label className={styles.label} { ...otherProps } >{ children }</label>);
};
