import Ajax from '../utils/ajax-helper';
import routes from '../api-routes';

/* index */
export const TERRITORY_INDEX_UPDATE_ITEMS = 'TERRITORY_INDEX_UPDATE_ITEMS';
export const TERRITORIES_INDEX_FETCH_REQUEST = 'TERRITORIES_INDEX_FETCH_REQUEST';

/* edit */
export const TERRITORY_EDIT_POST_REQUEST = 'TERRITORY_EDIT_POST_REQUEST';
export const TERRITORY_EDIT_FETCH_REQUEST = 'TERRITORY_EDIT_FETCH_REQUEST';
export const TERRITORY_EDIT_POPULATE_FORM = 'TERRITORY_EDIT_POPULATE_FORM';
export const TERRITORY_EDIT_SHOW_ERRORS = 'TERRITORY_EDIT_SHOW_ERRORS';
export const TERRITORY_SAVED = 'TERRITORY_SAVED';


/* index */
export function updateTerritoriesResult(territories) {
  return {
    type: TERRITORY_INDEX_UPDATE_ITEMS,
    territories
  };
};

export function fetchTerritories(params) {
  return dispatch => {
    dispatch({
      type: TERRITORIES_INDEX_FETCH_REQUEST
    });

    const url = routes.territories.index(params);

    Ajax.getJson(url).then(response => {
      dispatch(updateTerritoriesResult(response.data));
    });
  };
};

/* edit */
export function udpateTerritoryForm(territory) {
  return {
    type: TERRITORY_EDIT_POPULATE_FORM,
    territory
  };
};

export function fetchTerritoryForForm(slug) {
  return dispatch => {
    dispatch({
      type: TERRITORY_EDIT_FETCH_REQUEST
    });

    const url = routes.territories.show(slug);

    Ajax.getJson(url).then(response => {
      dispatch(udpateTerritoryForm(response.data));
    });
  };
};

export function showEditErrors(errors) {
  return {
    type: TERRITORY_EDIT_SHOW_ERRORS,
    errors
  }
}

function territorySaved(territory) {
  return {
    type: TERRITORY_SAVED,
    territory
  }
}

export function updateTerritory(slug, values) {
  return dispatch => {
    const url = routes.territories.show(slug);

    Ajax.patch(url, { territory: values }).then(response => {
      if (response.errors) {
        return dispatch(showEditErrors(response.errors));
      }

      dispatch(territorySaved(response.data))
    });
  };
};
