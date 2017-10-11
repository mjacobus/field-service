import React from 'react';

import styles from './icon.css';

const defaultSymbol = () => {
  return '?';
};

const symbols = {
  check: () => {
    return <span>&#x2713;</span>;
  },

  inProgress: () => {
    return <span>...</span>;
  },

  fail: () => {
    return <span>&#x2717;</span>;
  }
};

export default ({ type, ...otherProps }) => {
  const children = (symbols[type] || defaultSymbol)();

  return <div className={ [styles.icon, styles[type]].join(' ') } {...otherProps}>
    <span>{children}</span>
  </div>
};
