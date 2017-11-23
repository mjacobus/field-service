import React from 'react';

import {FormControl} from 'react-bootstrap';
import Block from '../input-block';
import Label from '../label';
import Errors from '../input-errors';

import {
  ButtonToolbar,
  ToggleButtonGroup,
  ToggleButton
} from 'react-bootstrap';


const onChangeWrapper = ({ name, onChange }) => value => (
  onChange({ target: { name, value } })
);

const createOptions = (options) => (
  options.map(
    (item, key) => <ToggleButton key={key} value={item[0]}>{item[1]}</ToggleButton>
  )
);

export default function ({ name, errors = null, onChange, options, label,...otherProps }) {
  let input = <ButtonToolbar>
      <ToggleButtonGroup onChange={ onChangeWrapper({ name, onChange }) } name={ name } type="radio" {...otherProps} >
        {createOptions(options)}
      </ToggleButtonGroup>
    </ButtonToolbar>;


  if (label) {
    input = <div><Label>{label}</Label>{input}</div>;
  }

  errors = <Errors errors={ errors } />

  return <Block>{input}{errors}</Block>;
}
