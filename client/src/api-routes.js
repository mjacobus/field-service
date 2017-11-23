import UrlHelper from './utils/url-helper';

const territoriesRoutes = {
  index: (params = {}) => {
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

territoriesRoutes.list = territoriesRoutes.index;

const publishersRoutes = {
  index: (params = {}) => {
    return UrlHelper.create('/api/publishers', params);
  }
}

territoriesRoutes.list = publishersRoutes.index;


const householdersRoutes = {
  create: (territorySlug) => {
    return UrlHelper.create(`/api/territories/${territorySlug}/householders`);
  }
}


export default {
  territories: territoriesRoutes,
  householders: householdersRoutes,
  publishers: publishersRoutes
}
