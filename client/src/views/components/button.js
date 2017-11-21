import React from 'react';
import Button from 'react-bootstrap/lib/Button';

const defaultStyle = {
  outline: 'none',
  background: '#4a6da7',
  color: 'white',
  borderRadius: 0
};

export default ({ bsStyle = 'primary', style = defaultStyle, ...otherProps }) => {
  return <Button style={ style } {...otherProps} />;
};
