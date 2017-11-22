import {connect} from 'react-redux';
import TerritoryForm from '../../../views/pages/territories/form';
import { resetPersisted, fetchTerritoryForForm, updateTerritory } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    ...state.territories.edit,
    territory: state.territories.currentTerritory,
    persisted: state.territories.edit.persisted
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchTerritory: (slug) => {
      dispatch(fetchTerritoryForForm(slug));
    },

    submitValues: (slug, values) => {
      dispatch(updateTerritory(slug, values));
    },

    resetPersisted: () => {
      dispatch(resetPersisted());
    }
  };
}

const TerritoryEditContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryForm);

export default TerritoryEditContainer;
