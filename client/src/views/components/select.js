import React from 'react';
import hashToArray from '../../utils/hash-to-array';

const defaultOnChange = () => {};

export default ({
    options = [],
    onCollectionChange = defaultOnChange,
  ...props
}) => {
  const toggle = (event)  => {
    const selectedValues = hashToArray(event.target.options)
      .filter(o => o.selected)
      .map(o => o.value);

    onCollectionChange(selectedValues);
  };

  return <select {...props} onChange={ toggle }>
    {
      options.map((option, key) => {
        return <option key={key} value={option.value}>{option.label}</option>;
      })
    }
  </select>;
};
