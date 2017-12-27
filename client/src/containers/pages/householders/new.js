import {connect} from 'react-redux';
import Form from '../../../views/pages/householders/form';
import {
  afterHouseholderCreated,
  createHouseholder
} from '../../../actions/householder-actions';

import {
  fetchTerritory,
} from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    ...state.householders.meta.create,
  };
}

function mapDispatchToProps(dispatch) {
  return {
    saveTerritory: (territorySlug, attributes) => {
      dispatch(createHouseholder(territorySlug, attributes));
    },

    onUnmount: (territorySlug) => {
      dispatch(afterHouseholderCreated());
      dispatch(fetchTerritory(territorySlug, { cache: false }));
    },
  };
}

const FormContainer = connect(mapStateToProps, mapDispatchToProps)(Form);

export default FormContainer;
