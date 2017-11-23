import React from 'react';

import HouseholderItem from '../shared/householder-item';

export default function ({ householders, onDelete }) {
  const last = householders.length - 1;

  return householders.map((householder, index) => {
    const separator = index !== last;

    return <HouseholderItem key={ householder.id } householder={ householder } separator={ separator } onDelete={ onDelete }/>;
  });
};
