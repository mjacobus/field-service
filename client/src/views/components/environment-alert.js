import React from 'react';
import style from './environment-alert.css';

const defaultMessage = 'This is a test environment. Uset it as you wish.';

const isDevelopmentMode = ()  => {
  return !!window.location.href.match(/localhost|staging/);
};

export default ({ message = defaultMessage}) => {
  return isDevelopmentMode() && <p className={style.envAlert}>{message}</p>;
};
