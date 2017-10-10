const defaultOptions = {
  credentials: 'include',
  headers: new Headers({
    'Accept': 'application/json'
  })
};

export default class {
  static getJson(path, queryParams = null) {
    return this.fetch(path, defaultOptions).then(this.parseResponse);
  }

  static fetch(path, options = {}) {
    return fetch(path, options);
  }

  static parseResponse(response) {
    return response.json();
  }
}
