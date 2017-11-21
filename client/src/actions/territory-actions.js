import Ajax from '../utils/ajax-helper';
import routes from '../api-routes';

export const FETCH_TERRITORIES = 'FETCH_TERRITORIES';
export const TERRITORIES_FETCHED = 'TERRITORIES_FETCHED';

export const FETCH_TERRITORY = 'FETCH_TERRITORY';
export const TERRITORY_FETCHED = 'TERRITORY_FETCHED';

export const RESET_PERSISTED = 'RESET_PERSISTED';

export const SHOW_FORM_ERRORS = 'SHOW_FORM_ERRORS';
export const TERRITORY_UPDATED = 'TERRITORY_UPDATED';
export const UPDATE_TERRITORY = 'UPDATE_TERRITORY';


/* index */
export function updateTerritoriesResult(territories) {
  return {
    type: TERRITORIES_FETCHED,
    territories
  };
};

export function fetchTerritories(params) {
  return dispatch => {
    dispatch({
      type: FETCH_TERRITORIES
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
    type: TERRITORY_FETCHED,
    territory
  };
};

export function fetchTerritoryForForm(slug) {
  return dispatch => {
    dispatch({
      type: FETCH_TERRITORY
    });

    const url = routes.territories.show(slug);

    Ajax.getJson(url).then(response => {
      dispatch(udpateTerritoryForm(response.data));
    });
  };
};

export function showEditErrors(errors) {
  return {
    type: SHOW_FORM_ERRORS,
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
  return (dispatch, getState) => {
    const url = routes.territories.show(slug);
    const oldTerritory = getState().territories.edit.territory;

    const changed = (oldTerritory.name !== values.name
      || oldTerritory.city !== values.city
      || oldTerritory.description !== values.description
    );


    if (!changed) {
      dispatch(territorySaved(oldTerritory));
      return;
    }

    Ajax.patch(url, { territory: values }).then(response => {
      if (response.errors) {
        dispatch(showEditErrors(response.errors));
        return;
      }

      dispatch(territorySaved(response.data))
    });
  };
};

export function resetPersisted() {
  return {
    type: RESET_PERSISTED
  }
}
