import React from 'react'

const getCookie = (name) => {
  const re = new RegExp(name + "=([^;]+)");
  let value = re.exec(document.cookie);
  return (value != null) ? unescape(value[1]) : null;
}

const token = () => {
  let tokenValue = (document.querySelector('[name="csrf-token"]') || {}).content || null;

  if (tokenValue === null) {
    tokenValue = getCookie('fs_form_token');
  }

  return tokenValue;
};

export default ({ action = '', method = 'post', children }) => {
  return <form action={action} method="post">
    <input name="utf8" type="hidden" value="✓" />
    <input type="hidden" name="_method" value={ method }/>
    <input type="hidden" name="authenticity_token" value={ token() }/>
    { children }
  </form>;
};
