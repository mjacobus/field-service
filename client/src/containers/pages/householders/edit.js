import {connect} from 'react-redux';
import Form from '../../../views/pages/householders/form';
import {
  afterHouseholderCreated,
  updateHouseholder,
  fetchHouseholder
} from '../../../actions/householder-actions';

function mapStateToProps(state) {
  return {
    ...state.householders.meta.create,
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
