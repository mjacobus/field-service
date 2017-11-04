import React, { Component } from 'react';
import {Row, Col} from 'react-bootstrap';
import LeftRightFrame from '../../components/left-right-frame';
import ContentToggler from '../../components/content-toggler';
import routes from '../../../api-routes';
import appRoutes from '../../../app-routes';
import Ajax from '../../../utils/ajax-helper';
import LoaderOrContent from '../../components/loader-or-content';
import Item from '../../components/property-value-label';
import Button from '../../components/button';
import HouseholderItem from '../shared/householder-item';
import TerritoryAssignments from '../shared/territory-assignments';
import { withRouter } from 'react-router-dom'

import t from '../../../translations';

import styles from '../../../global.css';

const fetchTerritory = (slug, callback) => {
  const url = routes.territories.show(slug);

  Ajax.getJson(url).then((response) => {
    callback(response.data);
  });
};

const renderActions = withRouter(({ territory, history }) => {
  const openPdf = ((event) => {
    window.open(appRoutes.territories.pdf(territory.slug), '_blank');
  });

  const goBack = ((event) => {
    history.push(appRoutes.territories.list())
  });

  const classes = [styles.wide, styles.fullLine, styles.decolapseDown];

  return (
    <div>
      <Button className={classes} onClick={ goBack } >{ t.back }</Button>
      <Button className={classes} onClick={ openPdf } >{ t.downloadPdf }</Button>
    </div>
  );
});

const renderTerritoryView = ({ territory }) =>  {
  const newHouseholderLink = appRoutes.householders.add({ territory });
  const addHouseholder = () => window.location.href = newHouseholderLink;

  const main = [
    <Item key={1} description={ t.name }>{ territory.name }</Item>,
    <Item key={2} description={ t.city }>{ territory.city }</Item>,
    <Item key={3} description={ t.description }>{ territory.description }</Item>,
  ];

  const assignmentsToggler = <ContentToggler openText={ t.hideAssignments } closedText={ t.showAssignments } open={ false }>
    <TerritoryAssignments assignments={territory.assignments} />
  </ContentToggler>;

  const last = territory.householders.length - 1;

  const householdersToggler = <ContentToggler openText={ t.hideHouseholders } closedText={ t.showHouseholders } open={ true }>
    <Row>
      <Col xs= { 12 }>
        <Button className={ styles.floatRight } onClick={ addHouseholder } >{ t.addHouseholder }</Button>
      </Col>
    </Row>

    {
      territory.householders.map((householder, index) => {
        let separator = index !== last;

        return <HouseholderItem key={ householder.id } householder={ householder } separator={ separator }/>;
      })
    }
  </ContentToggler>;

  return (
    <div>
      <div> { main }</div>
      { assignmentsToggler }
      { householdersToggler }
    </div>
  );
};

export default class TerritoryShow extends Component {
  constructor(props) {
    super(props);
    this.state = { territory: null, loading: true }
    this.slug = this.props.match.params.slug;
  }

  componentWillMount() {
    fetchTerritory(this.slug, (territory) => {
      this.setState({territory, loading: false});
    });
  }

  render() {
    const territory = this.state.territory;

    if (!territory) {
      return <div></div>;
    }

    const left  = renderActions({ territory })
    const right = renderTerritoryView({ territory });

    return <LoaderOrContent loading={ this.state.loading }>
        <LeftRightFrame leftComponent={ left } rightComponent={ right }/>
      </LoaderOrContent>;
  }
}
