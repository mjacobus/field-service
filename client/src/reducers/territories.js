import {
  TERRITORIES_UPDATE_ITEMS,
  TERRITORIES_FETCH_REQUEST,
  TERRITORY_EDIT_FETCH_REQUEST,
  TERRITORY_EDIT_POPULATE_FORM,
} from '../actions/territory-actions';

const DEFAULT_STATE = {
  list: [],
  edit: {
    territory: {},
    loading: true,
  },
};

export function territoriesReducer(state = DEFAULT_STATE, action) {
  switch (action.type) {
    case TERRITORIES_FETCH_REQUEST:
      return {
        list: {
          ...state.list,
          loading: true
        }
      };

    case TERRITORIES_UPDATE_ITEMS:
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
    default:
      return state;
  }
};
