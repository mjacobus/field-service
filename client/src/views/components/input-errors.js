import React from 'react';

import style from './input-errors.css';

export default function ({ errors }) {
  if (!errors) {
    errors = [];
  }

  if (errors && typeof(errors) !== 'object') {
    errors = [errors];
  }

  errors = errors.map((message, key) => {
    return <span key={ key } className={ style.inputError }>- { message }</span>;
  });

  if (errors.length === 0) {
    return null;
  }

  return <div className={ style.inputErrorContainer }>{ errors }</div>;
}
