import {connect} from 'react-redux';
import Form from '../../../views/pages/householders/form';
import { createHouseholder } from '../../../actions/householder-actions';

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

    submitValues: (territorySlug, values) => {
    },

    resetPersisted: () => {
    }
  };
}

const FormContainer = connect(mapStateToProps, mapDispatchToProps)(Form);

export default FormContainer;
