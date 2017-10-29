import React from 'react';
import style from './environment-alert.css';

import t from '../../translations';

const defaultMessage = t.testSystemMessage;

const isDevelopmentMode = ()  => {
  return !!window.location.href.match(/localhost|staging/);
};

export default ({ message = defaultMessage}) => {
  return isDevelopmentMode() && <p className={style.envAlert}>{message}</p>;
};
