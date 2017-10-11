import React from 'react';
import styles from './separator.css';

export default ({description, children, size = 10, ...otherProps}) => {
  return <div className={styles.separator} style={ { margin: `${size}px 0` } }></div>;
};
