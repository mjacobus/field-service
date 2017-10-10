import {
  TERRITORIES_UPDATE_ITEMS,
  TERRITORIES_FETCH_REQUEST
} from '../actions/territory-actions';

const DEFAULT_STATE = {
  list: []
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
    default:
      return state;
  }
};
