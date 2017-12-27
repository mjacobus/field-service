import React from 'react'

import cookies from '../../utils/cookies.js'

export default ({ action = '', method = 'post', children }) => {
  return <form action={action} method="post">
    <input name="utf8" type="hidden" value="✓" />
    <input type="hidden" name="_method" value={ method }/>
    <input type="hidden" name="authenticity_token" value={ cookies.getFormToken() }/>
    { children }
  </form>;
};
