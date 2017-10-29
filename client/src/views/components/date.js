import React from 'react'

const formatDate = (dateString) => {
  return dateString.split('-').reverse().join('/');
};

export default function ({ children, ...otherProps }) {
  const date = formatDate(children);

  return (<span { ...otherProps }>{date}</span>);
};
