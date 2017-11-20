import {connect} from 'react-redux';
import TerritoryShow from '../../../views/pages/territories/show';
// import { fetchTerritories } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    // territories: state.territories.list.items,
    // loading: state.territories.list.loading
  };
}

function mapDispatchToProps(dispatch) {
  return {
    // onInitialize: (params) => {
    //   dispatch(fetchTerritories(params));
    // }
  };
}

const TerritoryShowContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryShow);

export default TerritoryShowContainer;
