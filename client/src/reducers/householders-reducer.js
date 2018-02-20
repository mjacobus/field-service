import * as actions from '../actions/householder-actions';

const DEFAULT_META_CREATE = {
  persisted: false,
}

const DEFAULT_STATE = {
  householders: {
    currentHouseholder: null,
  },
  meta: {
    create: DEFAULT_META_CREATE
  }
}

function householdersReducer(state = DEFAULT_STATE, action) {
  switch(action.type) {
    case actions.CREATE_HOUSEHOLDER:
      return {
        ...state,
        meta: {
          create: {
            ...state.meta.create,
            loading: true,
          }
        }
      };

    case action.UPDATE_HOUSEHOLDER:
      return {
        ...state,
        meta: {
          update: {
            ...state.meta.update,
            loading: true,
          }
        }
      };

    case actions.HOUSEHOLDER_CREATED:
      return {
        ...state,
        meta: {
          create: {
            ...state.meta.create,
            loading: false,
            persisted: true,
          }
        }
      };

    case actions.DISPLAY_FORM_ERRORS:
      return {
        ...state,
        meta: {
          create: {
            ...state.meta.create,
            loading: false,
            errors: action.errors,
          }
        }
      };

    case actions.AFTER_HOUSEHOLDER_CREATED:
      return {
        ...state,
        meta: {
          create: DEFAULT_META_CREATE
        }
      };


    default: return state;
  }
}

export { householdersReducer };
