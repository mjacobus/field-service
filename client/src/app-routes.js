import UrlHelper from './utils/url-helper';

const fixUrl = (path) => {
  if (window.location.href.match(/3001/)) {
    return `http://localhost:3000${path}`
  }

  return path;
}

const territoriesRoutes = {
  index: (params = {}) => {
    return UrlHelper.create('/app/territories', params);
  },

  show: (slug, params = {})  => {
    return UrlHelper.create(`/app/territories/${slug}`, params);
  },

  map: (slug)  => {
    return fixUrl(UrlHelper.create(`/territories/${slug}/map`));
  },

  edit: (slug, params = {})  => {
    return UrlHelper.create(`/app/territories/${slug}/edit`, params);
  },

  pdf: (slug)  => {
    return fixUrl(UrlHelper.create(`/territories/${slug}.pdf`));
  }
}

const publishersRoutes = {
  list: (params = {}) => {
    console.log('depracated: use index');
    return fixUrl(UrlHelper.create('/publishers', params));
  },

  index: (params = {}) => {
    return fixUrl(UrlHelper.create('/publishers', params));
  },
}

const householdersRoutes = {
  /* TODO: remove */
  add: ({ territory }) => {
    return UrlHelper.create(`/app/territories/${territory.slug}/householders/new`);
  },

  new: (territorySlug) => {
    return UrlHelper.create(`/app/territories/${territorySlug}/householders/new`);
  },

  legacyAdd: ({ territory }) => {
    return fixUrl(UrlHelper.create(`/territories/${territory.slug}/householders/new`));
  }
}

const assignmentRoutes = {
  index: () => {
    return fixUrl(UrlHelper.create('/territory_assignments'));
  }
}

const main = {
  profile: () => {
    return '/profile/edit';
  },

  logout: () => {
    return '/sign_out';
  }
}

export default {
  territories: territoriesRoutes,
  householders: householdersRoutes,
  assignments: assignmentRoutes,
  publishers: publishersRoutes,
  main,
}
