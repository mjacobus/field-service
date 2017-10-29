import React from 'react'
import {FormattedMessage} from 'react-intl';

export default function (id, props = {}) {
  return <FormattedMessage id={id} defaultMmessage={id} { ...props } />;
};
