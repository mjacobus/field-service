import Ajax from '../utils/ajax-helper';

export const UPDATE_TERRITORIES = 'UPDATE_TERRITORIES';

export function updateTerritoriesResult(territories) {
  return {
    type: UPDATE_TERRITORIES,
    territories
  };
};

export function fetchTerritories() {
  return dispatch => {
    Ajax.getJson('/api/territories').then(response => {
      dispatch(updateTerritoriesResult(response.data));
    });
  };
};
