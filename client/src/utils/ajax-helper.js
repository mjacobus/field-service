import cookies from './cookies';

const defaultOptions = () => ({
  credentials: 'include',
  headers:{
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'X-CSRF-Token': cookies.getFormToken(),
  }
});

export default class {
  static getJson(path, queryParams = null) {
    return this.fetch(path, defaultOptions()).then(this.parseResponse).catch(this.parseResponse);
  }

  static fetch(path, options = {}) {
    return fetch(path, options);
  }

  static delete(path, data = {}) {
    return this.apiRequest(path, 'delete', data);
  }

  static patch(path, data = {}) {
    return this.apiRequest(path, 'put', data);
  }

  static post(path, data = {}) {
    return this.apiRequest(path, 'post', data);
  }

  static apiRequest(path, method, data) {
    let options = Object.assign({}, defaultOptions(), {
      method,
      body: JSON.stringify(data)
    });

    return this.fetch(path, options).then(this.parseResponse);
  }

  static parseResponse(response, b, c) {
    return response.json();
  }
}


const postJson = (url, payload = {}) => {
  const method = 'POST';

  // const options = Object.assign({}, defaultOptions(), {
  const options = Object.assign({}, {}, {
    method,
    body: JSON.stringify(payload)
  });

  return fetch(url, options);
}

export {
  postJson
};
