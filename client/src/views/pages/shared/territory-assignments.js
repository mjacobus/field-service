import React from 'react';

import Item from '../../components/property-value-label';
import TerritoryAssignmentItem from './territory-assignment-item';

export default ({ assignments }) => {
  let separator = true;
  const last = assignments.length - 1;

  return assignments.map((assignment, index) => {
    separator = index !== last;

    return (
      <TerritoryAssignmentItem key={assignment.id} item={ assignment } separator={ separator }>
        <Item description="Name" separator={ false }>
          { assignment.assignee.name }
        </Item>
      </TerritoryAssignmentItem>
    );
  });
};
