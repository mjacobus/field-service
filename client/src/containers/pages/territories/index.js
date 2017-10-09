import {connect} from 'react-redux';
import TerritoryList from '../../../views/pages/territories/index';
import { fetchTerritories } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    territories: state.territories.list
  };
}

function mapDispatchToProps(dispatch) {
  return {
    onInitialize: () => {
      dispatch(fetchTerritories());
    }
  };
}

const TerritoryListContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryList);

export default TerritoryListContainer;
