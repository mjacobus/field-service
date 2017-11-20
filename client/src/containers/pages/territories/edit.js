import {connect} from 'react-redux';
import TerritoryForm from '../../../views/pages/territories/form';
// import { fetchTerritories } from '../../../actions/territory-actions';

function mapStateToProps(state) {
  return {
    // territories: state.territories.list.items,
    // loading: state.territories.list.loading
  };
}

function mapDispatchToProps(dispatch) {
  return {
    submitValues: (values) => {
      console.log(values);
      // dispatch(fetchTerritories(params));
    }
  };
}

const TerritoryEditContainer = connect(mapStateToProps, mapDispatchToProps)(TerritoryForm);

export default TerritoryEditContainer;

