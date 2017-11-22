import {connect} from 'react-redux';
import TerritoryIndex from '../../../views/pages/territories/index';
import { fetchTerritories } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    ...state.territories.meta,
    territories: state.territories.territories,
  };
}

function mapDispatchToProps(dispatch) {
  return {
    fetchTerritories: (params) => {
      dispatch(fetchTerritories(params));
    }
  };
}

const TerritoryIndexContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryIndex);

export default TerritoryIndexContainer;
