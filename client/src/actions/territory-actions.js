import Ajax from '../utils/ajax-helper';

export const FETCH_TERRITORIES = 'FETCH_TERRITORIES';

export function putTerritoriesResult(territories) {
  return {
    type: FETCH_TERRITORIES,
    territories
  };
};

export function fetchTerritories() {
  return dispatch => {
    Ajax.getJson('/api/territories').then(response => {
      dispatch(putTerritoriesResult(response.data));
    });
  };
};
