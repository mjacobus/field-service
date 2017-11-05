import cookies from './cookies';

const defaultOptions = () => ({
  credentials: 'include',
  headers: new Headers({
    'Accept': 'application/json',
    'X-CSRF-Token': cookies.getFormToken(),
  })
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

  static apiRequest(path, method, data) {
    let options = Object.assign({}, defaultOptions(), {
      method,
      body: JSON.stringify(data)
    });

    return this.fetch(path, options).then(this.parseResponse).catch(this.parseResponse);
  }

  static parseResponse(response) {
    return response.json();
  }
}
