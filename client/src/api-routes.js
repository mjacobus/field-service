import UrlHelper from './utils/url-helper';

const territoriesRoutes = {
  list: (params = {}) => {
    if (params.assignedToIds) {
      params.assigned_to_ids = params.assignedToIds;
    }

    if (params.pendingReturn) {
      params.pending_return = 1;
    }

    delete params.assignedToIds;
    delete params.pendingReturn;

    return UrlHelper.create('/api/territories', params);
  },

  show: (slug, params = {})  => {
    return UrlHelper.create(`/api/territories/${slug}`, params);
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
