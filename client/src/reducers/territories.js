import {UPDATE_TERRITORIES} from '../actions/territory-actions';

const DEFAULT_STATE = {
  list: []
};

export function territoriesReducer(state = DEFAULT_STATE, action) {
  switch (action.type) {
    case UPDATE_TERRITORIES:
      return { list: action.territories };
    default:
      return state;
  }
};
