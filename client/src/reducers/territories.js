import {
  TERRITORY_INDEX_UPDATE_ITEMS,
  TERRITORIES_INDEX_FETCH_REQUEST,
  TERRITORY_EDIT_FETCH_REQUEST,
  TERRITORY_EDIT_POPULATE_FORM,
  TERRITORY_EDIT_POST_REQUEST,
  TERRITORY_EDIT_SHOW_ERRORS
} from '../actions/territory-actions';

const DEFAULT_STATE = {
  list: [],
  edit: {
    errors: null,
    territory: {},
    loading: true,
    posting: false,
  },
};

export function territoriesReducer(state = DEFAULT_STATE, action) {
  switch (action.type) {
    case TERRITORIES_INDEX_FETCH_REQUEST:
      return {
        list: {
          ...state.list,
          loading: true
        }
      };

    case TERRITORY_INDEX_UPDATE_ITEMS:
      return {
        list: {
          items: action.territories,
          loading: false
        }
      };

    case TERRITORY_EDIT_FETCH_REQUEST:
      return {
        edit: {
          ...state.edit,
          loading: true
        }
      };

    case TERRITORY_EDIT_POPULATE_FORM:
      return {
        edit: {
          territory: action.territory,
          loading: false
        }
      };

    case TERRITORY_EDIT_POST_REQUEST:
      return {
        edit: {
          ...state.edit,
          posting: true
        }
      };

    case TERRITORY_EDIT_SHOW_ERRORS:
      return {
        edit: {
          ...state.edit,
          errors: action.errors,
          posting: false
        }
      };

    default:
      return state;
  }
};
