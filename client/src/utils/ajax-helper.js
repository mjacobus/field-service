const defaultOptions = {
  credentials: 'include',
  headers: new Headers({
    'Accept': 'application/json'
  })
};

class Ajax {

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

export default Ajax;
