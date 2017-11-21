import {
  TERRITORY_INDEX_UPDATE_ITEMS,
  TERRITORIES_INDEX_FETCH_REQUEST,
  TERRITORY_EDIT_FETCH_REQUEST,
  TERRITORY_EDIT_POPULATE_FORM,
  TERRITORY_EDIT_POST_REQUEST,
  TERRITORY_SAVED,
  TERRITORY_EDIT_SHOW_ERRORS
} from '../actions/territory-actions';

const DEFAULT_STATE = {
  list: {
    items: []
  },
  edit: {
    errors: null,
    territory: {},
    loading: true,
    posting: false,
    persisted: false,
  },
};

export function territoriesReducer(state = DEFAULT_STATE, action) {
  switch (action.type) {
    case TERRITORIES_INDEX_FETCH_REQUEST:
      return {
        ...state,
        list: {
          ...state.list,
          loading: true
        }
      };

    case TERRITORY_INDEX_UPDATE_ITEMS:
      return {
        ...state,
        list: {
          items: action.territories,
          loading: false
        }
      };

    case TERRITORY_EDIT_FETCH_REQUEST:
      return {
        ...state,
        edit: {
          ...state.edit,
          loading: true
        }
      };

    case TERRITORY_EDIT_POPULATE_FORM:
      return {
        ...state,
        edit: {
          territory: action.territory,
          loading: false
        }
      };

    case TERRITORY_EDIT_POST_REQUEST:
      return {
        ...state,
        edit: {
          ...state.edit,
          posting: true
        }
      };

    case TERRITORY_EDIT_SHOW_ERRORS:
      return {
        ...state,
        edit: {
          ...state.edit,
          errors: action.errors,
          posting: false
        }
      };

    case TERRITORY_SAVED:
      return {
        ...state,
        edit: {
          ...state.edit,
          persisted: true,
        }
      };

    default:
      return state;
  }
};
