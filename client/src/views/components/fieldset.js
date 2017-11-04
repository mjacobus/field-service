import React from 'react';

import styles from './fieldset.css';

export default ({ children }) => {
  return (<fieldset className={styles.fieldset}>{ children }</fieldset>);
};

