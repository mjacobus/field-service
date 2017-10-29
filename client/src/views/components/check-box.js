import React from 'react';

const defaultOnChange = () => {};

export default function ({ onChange = defaultOnChange, props }) {
  const customOnChange = (event) => {
    onChange(event.target.checked);
  };

  return (<input type="checkbox" onChange={ customOnChange } { ...props } />);
};
