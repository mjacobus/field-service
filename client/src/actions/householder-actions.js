import Ajax from '../utils/ajax-helper';
import routes from '../api-routes';
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

function prepareFormAttributes(attributes) {
  return {
    householder: {
      street_name: attributes.streetName,
      house_number: attributes.houseNumber,
      name: attributes.name,
      show: attributes.speakTheLanguage,
      do_not_visit_date: attributes.doNotVisitDate,
    }
  }
}

function createHouseholder(territorySlug, attributes) {
  return (dispatch, getState) => {
    attributes = prepareFormAttributes(attributes);

    dispatch(requestCreateHouseholder());

    const url = routes.householders.create(territorySlug);

    Ajax.post(url).then(response => {
      if (response.errors) {
        dispatch(householderCreated(null))
        return;
      }

      dispatch(householderCreated(null))
    });
  }
}

export default function () {};

export {
  fetchHouseholder,
  createHouseholder,
}
