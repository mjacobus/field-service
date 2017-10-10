import UrlHelper from './utils/url-helper';

const territoriesRoutes = {
  list: (params = {}) => {
    return UrlHelper.create('/api/territories', params);
  }
}

export default {
  territories: territoriesRoutes
}
