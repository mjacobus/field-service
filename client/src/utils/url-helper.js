import queryString from 'query-string';

export default class UrlHelper {
  static create(url, params = {}) {
    const q = queryString.stringify(params, {
      arrayFormat: 'bracket'
    });

    if (q !== '') {
      return url + '?' + q;
    }

    return url;
  }

  static onlyPath(url) {
    return url.replace(/^(http(s)?:\/\/[\da-z.]+(:[\d]+)?)?/, '');
  }
}
