import Ajax from '../utils/ajax-helper';
import routes from '../api-routes';

export const TERRITORIES_UPDATE_ITEMS = 'TERRITORIES_UPDATE_ITEMS';
export const TERRITORIES_FETCH_REQUEST = 'TERRITORIES_FETCH_REQUEST';

export function updateTerritoriesResult(territories) {
  return {
    type: TERRITORIES_UPDATE_ITEMS,
    territories
  };
};

export function fetchTerritories(params) {
  return dispatch => {
    dispatch({
      type: TERRITORIES_FETCH_REQUEST
    });

    const url = routes.territories.index(params);

    Ajax.getJson(url).then(response => {
      dispatch(updateTerritoriesResult(response.data));
    });
  };
};
