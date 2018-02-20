import {connect} from 'react-redux';
import Form from '../../../views/pages/householders/form';
import hash from '../../../utils/hash-utils';

import {
  updateHouseholder,
  fetchHouseholder
} from '../../../actions/householder-actions';

const normalizeHouseholderKeys = (object) => {
  if (!object) {
    return null;
  }

  return hash.snakeToCamel(object);
};

function mapStateToProps(state) {
  return {
    ...state.householders.meta.update,
    values: normalizeHouseholderKeys(state.householders.currentHouseholder)
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchHouseholder: (territorySlug, id) => {
      dispatch(fetchHouseholder(territorySlug, id));
    },

    submitValues: (territorySlug, householder, attributes) => {
      dispatch(updateHouseholder(territorySlug, householder, attributes));
    },

  };
}

const FormContainer = connect(mapStateToProps, mapDispatchToProps)(Form);

export default FormContainer;
