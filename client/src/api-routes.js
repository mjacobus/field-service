import UrlHelper from './utils/url-helper';

const territoriesRoutes = {
  list: (params = {}) => {
    console.log('params', params);
    return UrlHelper.create('/api/territories', params);
  }
}

const publishersRoutes = {
  list: (params = {}) => {
    return UrlHelper.create('/api/publishers', params);
  }
}

export default {
  territories: territoriesRoutes,
  publishers: publishersRoutes
}
