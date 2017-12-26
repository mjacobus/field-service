import Ajax from '../utils/ajax-helper';
import routes from '../api-routes';
import comparator from '../utils/comparator';

export const FETCH_TERRITORIES = 'FETCH_TERRITORIES';
export const TERRITORIES_FETCHED = 'TERRITORIES_FETCHED';

export const FETCH_TERRITORY = 'FETCH_TERRITORY';
export const TERRITORY_FETCHED = 'TERRITORY_FETCHED';

export const RESET_METADATA = 'RESET_METADATA';

export const SHOW_FORM_ERRORS = 'SHOW_FORM_ERRORS';
export const TERRITORY_UPDATED = 'TERRITORY_UPDATED';
export const UPDATE_TERRITORY = 'UPDATE_TERRITORY';

/* index */
function updateTerritoriesResult(territories) {
  return {
    type: TERRITORIES_FETCHED,
    territories
  };
};

export function fetchTerritories(params) {
  return (dispatch, getState) => {

    dispatch({
      type: FETCH_TERRITORIES,
      params: params,
    });

    const url = routes.territories.index(params);

    Ajax.getJson(url).then(response => {
      dispatch(updateTerritoriesResult(response.data));
    });
  };
};

/* edit */
function setCurrentTerritory(territory) {
  return {
    type: TERRITORY_FETCHED,
    territory
  };
};

export function fetchTerritory(slug, options = { cache: true }) {
  return (dispatch, getState) => {
    const currentTerritory = getState().territories.currentTerritory;
    const useCache = (options.cache && currentTerritory && currentTerritory.slug === slug);

    if (useCache) {
      dispatch(setCurrentTerritory(currentTerritory));
      return;
    }

    dispatch({ type: FETCH_TERRITORY });

    const url = routes.territories.show(slug);

    Ajax.getJson(url).then(response => {
      dispatch(setCurrentTerritory(response.data));
    });
  };
};

function showEditErrors(errors) {
  return {
    type: SHOW_FORM_ERRORS,
    errors
  }
}

function territorySaved(territory) {
  return {
    type: TERRITORY_UPDATED,
    territory
  }
}

function requestTerritoryUpdate() {
  return { type: UPDATE_TERRITORY }
}

export function updateTerritory(slug, values) {
  return (dispatch, getState) => {
    const url = routes.territories.show(slug);
    const oldTerritory = getState().territories.currentTerritory;

    const changed = !comparator.hash.equal(
      oldTerritory, values, { only: [ 'name', 'city', 'description']}
    );

    dispatch(requestTerritoryUpdate());

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
    type: RESET_METADATA
  }
}
