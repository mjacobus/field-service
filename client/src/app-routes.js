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
  add: ({ territory }) => {
    return fixUrl(UrlHelper.create(`/territories/${territory.slug}/householders/new`));
  }
}

const assignmentRoutes = {
  index: () => {
    return fixUrl(UrlHelper.create('/territory_assignments'));
  }
}

export default {
  territories: territoriesRoutes,
  householders: householdersRoutes,
  assignments: assignmentRoutes,
  publishers: publishersRoutes
}
