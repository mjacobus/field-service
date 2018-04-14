import cookies from './cookies';

const defaultOptions = () => ({
  credentials: 'include',
  headers: new Headers({
    'Accept': 'application/json',
    'Content-Type': 'application/json',
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

  static patch(path, data = {}) {
    return this.apiRequest(path, 'put', data);
  }

  static post(path, data = {}) {
    return this.apiRequest(path, 'post', data);
  }

  static postJson(path, data = {}) {
    return this.fetchJson('POST', path, data);
  }

  static fetchJson(method, path, data = {}) {
    const options = Object.assign({}, defaultOptions(), {
      method,
      body: JSON.stringify(data)
    });

    return this.fetch(path, options).then((response) => {
      // console.log('RESPONSE');
      // if (response.ok) {
      //   return response.json();
      // }
      //
      // // return response.json();
      // throw new Error('haa');
    });
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
