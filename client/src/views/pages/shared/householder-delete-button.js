import React from 'react';

import Button from '../../components/button';

import t from '../../../translations';
import ajax from '../../../utils/ajax-helper';

const noop = (response) => { console.log('No onDelete provided:', response) };

const handleDeleteHouseholder = ({ householder, onDelete, onDeleteError }) => {
  return () => {
    const item = [householder.name, householder.address].join(', ');
    const message = t.confirmDelete(item);

    if (window.confirm(message)) {
      ajax.delete(householder.links.destroy)
        .then(response => onDelete(response, householder))
        .catch(error => onDeleteError(error, householder));
    }
  };
};

export default ({ householder, onDelete, onDeleteError = noop, ...otherProps }) => {
  return <Button onClick={ handleDeleteHouseholder({ householder, onDelete, onDeleteError }) } {...otherProps}>{ t.delete }</Button>
};
