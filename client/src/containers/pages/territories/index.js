import {connect} from 'react-redux';
import TerritoryIndex from '../../../views/pages/territories/index';
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

const TerritoryIndexContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryIndex);

export default TerritoryIndexContainer;
