import React from 'react'
import {FormattedMessage} from 'react-intl';

import messages from "../translations/pt";

const text = (id, { values = {} }) => {
  let message = messages[id] || id;

  Object.keys(values).forEach((key) => {
    message = message.replace(`{${key}}`, values[key]);
  });

  return message;
};

const html = (id, props = {}) => {
  return <FormattedMessage id={id} defaultMmessage={id} { ...props } />;
};

const translations = { html, text };

export default translations;
