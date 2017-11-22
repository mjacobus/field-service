import React from 'react';

const style = {
  marginBottom: '10px'
};

export default function ({ children, ...otherProps }) {
  return <div style={ style } {...otherProps}>{children}</div>;
}
