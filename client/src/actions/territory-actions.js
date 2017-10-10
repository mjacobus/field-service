import Ajax from '../utils/ajax-helper';

export const TERRITORIES_UPDATE_ITEMS = 'TERRITORIES_UPDATE_ITEMS';
export const TERRITORIES_FETCH_REQUEST = 'TERRITORIES_FETCH_REQUEST';

export function updateTerritoriesResult(territories) {
  return {
    type: TERRITORIES_UPDATE_ITEMS,
    territories
  };
};

export function fetchTerritories() {
  return dispatch => {
    dispatch({
      type: TERRITORIES_FETCH_REQUEST
    });

    Ajax.getJson('/api/territories').then(response => {
      dispatch(updateTerritoriesResult(response.data));
    });
  };
};
