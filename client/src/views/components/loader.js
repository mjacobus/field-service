import React from 'react';
import loaderImage from './assets/loader.gif';
import styles from './loader.css';

export default ({ loading = true, size = 50, alt = 'Loading...' }) => {
  return (
    <div className={styles.loader}>
      <img height={size} width={size} src={loaderImage} alt={ alt } />
    </div>
  );
};
