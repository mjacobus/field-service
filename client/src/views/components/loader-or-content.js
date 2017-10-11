import React from 'react';
import Loader from './loader';

export default ({loading, children}) => {
  let classNames = ['loader'];

  if (loading) {
    classNames.push('loading')
  }

  return <div className={ classNames.join(' ') }> { loading ? <Loader /> : children} </div>
};
