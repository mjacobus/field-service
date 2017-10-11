import UrlHelper from './utils/url-helper';

const fixUrl = (path) => {
  if (window.location.href.match(/3001/)) {
    return `http://localhost:3000/${path}`
  }

  return path;
}

const territoriesRoutes = {
  list: (params = {}) => {
    return UrlHelper.create('/app/territories', params);
  },

  show: (slug, params = {})  => {
    return UrlHelper.create(`/app/territories/${slug}`, params);
  },

  pdf: (slug)  => {
    return fixUrl(UrlHelper.create(`/territories/${slug}.pdf`));
  }
}

const publishersRoutes = {
  list: (params = {}) => {
    return UrlHelper.create('/app/publishers', params);
  }
}

export default {
  territories: territoriesRoutes,
  publishers: publishersRoutes
}
