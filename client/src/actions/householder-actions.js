// import Ajax from '../utils/ajax-helper';
// import routes from '../api-routes';
// import comparator from '../utils/comparator';

export const FETCH_HOUSEHOLDER = 'FETCH_HOUSEHOLDER';
export const HOUSEHOLDER_FETCHED = 'HOUSEHOLDER_FETCHED';

export const RESET_METADATA = 'RESET_METADATA';

export const SHOW_FORM_ERRORS = 'SHOW_FORM_ERRORS';
export const UPDATE_HOUSEHOLDER = 'UPDATE_HOUSEHOLDER';
export const HOUSEHOLDER_UPDATED = 'HOUSEHOLDER_UPDATED';

export const CREATE_HOUSEHOLDER = 'CREATE_HOUSEHOLDER';
export const HOUSEHOLDER_CREATED = 'HOUSEHOLDER_CREATED';

function fetchHouseholder(territorySlug, id) {
  return {
    type: FETCH_HOUSEHOLDER,
    territorySlug,
    id
  }
}

function requestCreateHouseholder() {
  return { type: CREATE_HOUSEHOLDER };
}

function householderCreated(householder) {
  return {
    type: HOUSEHOLDER_CREATED,
    householer: householder
  };
}

function createHouseholder(territorySlug, attributes) {
  return (dispatch, getState) => {
      console.log('creating...');
    dispatch(requestCreateHouseholder());

    setTimeout(() => {
      dispatch(householderCreated(null))
    }, 1000);
  }
}

export default function () {};

export {
  fetchHouseholder,
  createHouseholder,
}
