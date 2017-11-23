import React from 'react';
import { withRouter } from 'react-router-dom'

import Button from '../../components/button';
import appRoutes from '../../../app-routes';

import t from '../../../translations';


const ButtonNewHouseholder = function ({ territory, onDelete, legacyUrl, label, history, ...otherProps }) {
  label = label || t.addHouseholder;

  const props = {};

  let href = appRoutes.householders.legacyAdd({ territory });

  if (!legacyUrl) {
    href =  appRoutes.householders.add({ territory });

    props.onClick = (event) => {
      event.preventDefault();

      appRoutes.householders.add({ territory });
      history.push(href);
    }
  }

  props.href = href;

  const { staticContext, match, location, ...otherValidProps }  = otherProps;

  return <Button {...props} {...otherValidProps} >{ label }</Button>;
};

export default withRouter(ButtonNewHouseholder);
