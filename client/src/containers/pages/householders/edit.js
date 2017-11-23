import {connect} from 'react-redux';
import Form from '../../../views/pages/householders/form';
import { createHouseholder } from '../../../actions/householder-actions';

function mapStateToProps(state) {
  return {
    ...state.territories.meta.create,
    territory: state.territories.currentTerritory,
  };
}

function mapDispatchToProps(dispatch) {
  return {
    saveTerritory: (territorySlug, attributes) => {
      console.log('saveTerritory')
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
