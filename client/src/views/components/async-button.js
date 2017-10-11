import React from 'react';
import Button from './button';

const defaultAction = () => { console.log('no action given')  };

export default (
  {
    children,
    bsStyle     = 'primary',
    loading     = true,
    loadingText = null,
    asyncAction = defaultAction,
    ...otherProps
  }
) => {
  let text = null;

  if (loading && loadingText) {
    text = loadingText;
  } else {
    text = children;
  }

  const dispatchIfNotLoading = (event) => {
    if (!loading) {
      asyncAction(event);
    }
  }

  const props = {...otherProps, bsStyle};

  return <Button {...props} disabled={ loading } onClick={ dispatchIfNotLoading }>{text}</Button>;
};
