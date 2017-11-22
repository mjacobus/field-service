import {connect} from 'react-redux';
import TerritoryForm from '../../../views/pages/territories/form';
import { resetPersisted, fetchTerritory, updateTerritory } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    ...state.territories.meta,
    territory: state.territories.currentTerritory,
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchTerritory: (slug) => {
      dispatch(fetchTerritory(slug));
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
