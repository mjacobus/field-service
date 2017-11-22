import * as actions from '../actions/territory-actions';

const DEFAULT_STATE = {
  currentTerritory: {},
  list: {
    items: []
  },
  edit: {
    errors: null,
    loading: true,
    posting: false,
    persisted: false,
  },
};

export function territoriesReducer(state = DEFAULT_STATE, action) {
  switch (action.type) {
    case actions.FETCH_TERRITORIES:
      return {
        ...state,
        list: {
          ...state.list,
          loading: true
        }
      };

    case actions.TERRITORIES_FETCHED:
      return {
        ...state,
        list: {
          items: action.territories,
          loading: false
        }
      };

    case actions.FETCH_TERRITORY:
      return {
        ...state,
        edit: {
          ...state.edit,
          persisted: false,
          loading: true
        }
      };

    case actions.TERRITORY_FETCHED:
      return {
        ...state,
        currentTerritory: action.territory,
        edit: {
          loading: false
        }
      };

    case actions.UPDATE_TERRITORY:
      return {
        ...state,
        edit: {
          ...state.edit,
          posting: true
        }
      };

    case actions.SHOW_FORM_ERRORS:
      return {
        ...state,
        edit: {
          ...state.edit,
          errors: action.errors,
          posting: false
        }
      };

    case actions.TERRITORY_UPDATED:
      return {
        ...state,
        edit: {
          ...state.edit,
          persisted: true,
        }
      };

    case actions.RESET_PERSISTED:
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
