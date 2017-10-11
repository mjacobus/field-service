import React from 'react';
import Separator from './separator';

import styles from './property-value-label.css';

export default ({description, children, separator = { size: 10 }, hideOnEmpty = true, ...otherProps}) => {
  if (hideOnEmpty && !children) {
    return (<div></div>);
  }

  const item = <div {...otherProps}>
    <div className={ styles.description }>{ description }</div>{ children }
  </div>;

  if (separator) {
    return (<div>{item} <Separator {...separator} /></div>);
  }

  return item;
};
