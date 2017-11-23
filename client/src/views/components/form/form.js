import React from 'react';

import { FormButton } from '../form';

export default function ({ children, buttons = [], ...otherProps }) {
  return <form {...otherProps}>
    { children }
    { buttons.map((props, index) => <FormButton key={ index } {...props} />) }
  </form>
};
