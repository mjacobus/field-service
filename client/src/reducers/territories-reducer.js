import {
  TERRITORIES_FETCHED,
  FETCH_TERRITORIES,
  FETCH_TERRITORY,
  TERRITORY_FETCHED,
  UPDATE_TERRITORY,
  TERRITORY_UPDATED,
  RESET_PERSISTED,
  SHOW_FORM_ERRORS
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
    case FETCH_TERRITORIES:
      return {
        ...state,
        list: {
          ...state.list,
          loading: true
        }
      };

    case TERRITORIES_FETCHED:
      return {
        ...state,
        list: {
          items: action.territories,
          loading: false
        }
      };

    case FETCH_TERRITORY:
      return {
        ...state,
        edit: {
          ...state.edit,
          persisted: false,
          loading: true
        }
      };

    case TERRITORY_FETCHED:
      return {
        ...state,
        edit: {
          territory: action.territory,
          loading: false
        }
      };

    case UPDATE_TERRITORY:
      return {
        ...state,
        edit: {
          ...state.edit,
          posting: true
        }
      };

    case SHOW_FORM_ERRORS:
      return {
        ...state,
        edit: {
          ...state.edit,
          errors: action.errors,
          posting: false
        }
      };

    case TERRITORY_UPDATED:
      return {
        ...state,
        edit: {
          ...state.edit,
          persisted: true,
        }
      };

    case RESET_PERSISTED:
      return {
        ...state,
        edit: {
          ...state.edit,
          persisted: false,
        }
      };

    default:
      return state;
  }
};
