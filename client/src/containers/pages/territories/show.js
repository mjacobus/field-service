import {connect} from 'react-redux';
import TerritoryShow from '../../../views/pages/territories/show';
import { fetchTerritoryForForm } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    ...state.territories.meta,
    territory: state.territories.currentTerritory
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchTerritory: (slug) => {
      dispatch(fetchTerritoryForForm(slug));
    }
  };
}

const TerritoryShowContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryShow);

export default TerritoryShowContainer;
