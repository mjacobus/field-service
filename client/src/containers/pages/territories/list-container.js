import {connect} from 'react-redux';
import TerritoryList from '../../../views/pages/territories/list';
import { fetchTerritories } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    territories: state.territories.list.items,
    loading: state.territories.list.loading
  };
}

function mapDispatchToProps(dispatch) {
  return {
    onInitialize: (params) => {
      dispatch(fetchTerritories(params));
    }
  };
}

const TerritoryListContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryList);

export default TerritoryListContainer;
