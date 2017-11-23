import React from 'react';
import { withRouter } from 'react-router-dom';

import Button from '../../components/button';

import globalStyle from '../../../global.css';

const FormButton = ({ label, history, classNames = null, linkTo = null, /* avoid warning*/ staticContext, ...otherProps}) => {
  classNames = classNames || [ globalStyle.wide, globalStyle.spaceAbove];

  if (linkTo) {
    otherProps.onClick = (event) => {
      event.preventDefault();
      history.push(linkTo);
    };

    otherProps.href = linkTo;
  }

  return <Button className={ classNames } {...otherProps} >{ label }</Button>;
};

export default withRouter(FormButton);
