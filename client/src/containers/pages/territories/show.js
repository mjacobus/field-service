import {connect} from 'react-redux';
import TerritoryShow from '../../../views/pages/territories/show';
import { fetchTerritory } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    ...state.territories.meta,
    territory: state.territories.currentTerritory
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchTerritory: (slug, options) => {
      dispatch(fetchTerritory(slug, options));
    }
  };
}

const TerritoryShowContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryShow);

export default TerritoryShowContainer;
