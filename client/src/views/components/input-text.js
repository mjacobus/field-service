import React from 'react';

import {FormControl} from 'react-bootstrap';
import Label from './label';
import Errors from './input-errors';
import Block from './input-block';

export default function ({ name = null, label = null, errors = null, ...otherProps }) {
  const elements = [];

  if (label) {
    elements.push(<Label key={ `${name}-label` }>{ label }</Label>);
  }

  elements.push(<FormControl key={ name } {...otherProps} name={ name } type="text" />) ;
  elements.push(<Errors key={ `${name}-errors` } errors={ errors }/>) ;

  return <Block>{elements}</Block>;
}
