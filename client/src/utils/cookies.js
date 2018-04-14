const getCookie = (name) => {
  const re = new RegExp(name + "=([^;]+)");

  let value = re.exec(document.cookie);
  return (value != null) ? unescape(value[1]) : null;
}

const token = () => {
  if (typeof(document) === 'undefined') {
    return 'fakeTestToken';
  }

  return getCookie('fs_form_token');
};

export default {
  get: getCookie,
  getFormToken: token
}
