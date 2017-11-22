import * as actions from '../actions/territory-actions';
const DEFAULT_META = {
  errors: {},
  loading: true,
  posting: false,
  persisted: false,
};

const DEFAULT_STATE = {
  currentTerritory: null,
  territories: [],
  meta: DEFAULT_META,
};

export function territoriesReducer(state = DEFAULT_STATE, action) {
  switch (action.type) {
    case actions.FETCH_TERRITORIES:
      return {
        ...state,
        meta: {
          ...state.meta,
          loading: true,
        },
      };

    case actions.TERRITORIES_FETCHED:
      return {
        ...state,
        territories: action.territories,
        meta: {
          ...state.meta,
          loading: false,
        },
      };

    case actions.FETCH_TERRITORY:
      return {
        ...state,
        meta: {
          ...state.edit,
          persisted: false,
          loading: true
        }
      };

    case actions.TERRITORY_FETCHED:
      return {
        ...state,
        currentTerritory: action.territory,
        meta: {
          loading: false
        }
      };

    case actions.UPDATE_TERRITORY:
      return {
        ...state,
        meta: {
          ...state.edit,
          posting: true
        }
      };

    case actions.SHOW_FORM_ERRORS:
      return {
        ...state,
        meta: {
          ...state.edit,
          errors: action.errors,
          posting: false
        }
      };

    case actions.TERRITORY_UPDATED:
      return {
        ...state,
        meta: {
          ...state.edit,
          persisted: true,
        }
      };

    case actions.RESET_METADATA:
      return {
        ...state,
        meta: DEFAULT_META
      };

    default:
      return state;
  }
};
