import Ajax from '../utils/ajax-helper';
import routes from '../api-routes';
import hash from '../utils/hash-utils';

export const FETCH_HOUSEHOLDER = 'FETCH_HOUSEHOLDER';
export const HOUSEHOLDER_FETCHED = 'HOUSEHOLDER_FETCHED';

export const RESET_METADATA = 'RESET_METADATA';

export const SHOW_FORM_ERRORS = 'SHOW_FORM_ERRORS';
export const UPDATE_HOUSEHOLDER = 'UPDATE_HOUSEHOLDER';
export const HOUSEHOLDER_UPDATED = 'HOUSEHOLDER_UPDATED';

export const CREATE_HOUSEHOLDER = 'CREATE_HOUSEHOLDER';
export const HOUSEHOLDER_CREATED = 'HOUSEHOLDER_CREATED';
export const DISPLAY_FORM_ERRORS = 'DISPLAY_FORM_ERRORS';
export const AFTER_HOUSEHOLDER_CREATED = 'AFTER_HOUSEHOLDER_CREATED';

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

function displayFormErrors(errors) {
  return {
    type: DISPLAY_FORM_ERRORS,
    errors: errors
  };
}

function prepareFormAttributes(attributes) {
  const defaultValues = {
      street_name: '',
      house_number: '',
      name: '',
      show: '1',
      do_not_visit_date: '',
  };

  const newValues = {
    street_name: attributes.streetName || defaultValues.street_name,
    house_number: attributes.houseNumber || defaultValues.house_number,
    name: attributes.name || defaultValues.name,
    show: attributes.speakTheLanguage || defaultValues.show,
    do_not_visit_date: attributes.doNotVisitDate || defaultValues.do_not_visit_date,
  };

  return { householder: Object.assign(defaultValues, newValues) };
}

function prepareFormErrors(errors) {
  let newErrors = Object.assign({}, errors);

  newErrors = hash.renameProperty('street_name', 'streetName', newErrors);
  newErrors = hash.renameProperty('house_number', 'houseNumber', newErrors);
  newErrors = hash.renameProperty('show', 'speakTheLanguage', newErrors);
  newErrors = hash.renameProperty('do_not_visit_date', 'doNotVisitDate', newErrors);

  return newErrors;
}

function createHouseholder(territorySlug, attributes) {
  return (dispatch, getState) => {
    attributes = prepareFormAttributes(attributes);

    dispatch(requestCreateHouseholder());

    const url = routes.householders.create(territorySlug);

    Ajax.post(url, attributes).then(response => {
      if (response.errors) {
        dispatch(displayFormErrors(prepareFormErrors(response.errors)))
        return;
      }

      dispatch(householderCreated(response.data));
    });
  }
}

function afterHouseholderCreated() {
  return {
    type: AFTER_HOUSEHOLDER_CREATED
  };
}

export default function () {};

export {
  fetchHouseholder,
  createHouseholder,
  afterHouseholderCreated,
}
