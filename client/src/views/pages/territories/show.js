import React, { Component } from 'react';
import {Row, Col} from 'react-bootstrap';
import LeftRightFrame from '../../components/left-right-frame';
import ContentToggler from '../../components/content-toggler';
import Separator from '../../components/separator';
import Date from '../../components/date';
import routes from '../../../api-routes';
import appRoutes from '../../../app-routes';
import Ajax from '../../../utils/ajax-helper';
import LoaderOrContent from '../../components/loader-or-content';
import Item from '../../components/property-value-label';
import Button from '../../components/button';
import HouseholderItem from '../shared/householder-item';
import TerritoryAssignments from '../shared/territory-assignments';
import ReturnTerritoryButton from '../shared/territory-return-button';
import { withRouter } from 'react-router-dom'

import t from '../../../translations';

import styles from '../../../global.css';

const fetchTerritory = (slug, callback) => {
  const url = routes.territories.show(slug);

  Ajax.getJson(url).then((response) => {
    callback(response.data);
  });
};

const newHouseholderButton = ({ territory, classes }) => {
  return <Button
    className={ classes }
    href={ appRoutes.householders.add({ territory }) }
  >{ t.addHouseholder }</Button>
};

const renderActions = withRouter(({ territory, history }) => {
  const classes = [styles.wide, styles.fullLine, styles.decolapseDown];
  let assignmentButton = null;

  if (territory.links.return) {
    assignmentButton = <ReturnTerritoryButton className={ classes } territory={ territory } />;
  } else {
    assignmentButton = <Button className={ classes } href={ territory.links.assign }>{ t.assignTerritory }</Button>;
  }

  return (
    <div>
      <Button className={classes} onClick={ () => history.push(appRoutes.territories.index()) } >{ t.back }</Button>
      <Button className={classes} target="_blank" href={ appRoutes.territories.pdf(territory.slug) } >{ t.downloadPdf }</Button>
      <Button className={classes} onClick={ () => history.push(appRoutes.territories.edit(territory.slug)) } >{ t.edit }</Button>
      { newHouseholderButton({ territory, classes }) }
      { assignmentButton }
    </div>
  );
});

const renderTerritoryView = ({ territory, householderDeleteCallback }) =>  {

  let main = [
    <Item key={1} description={ t.name }>{ territory.name }</Item>,
    <Item key={2} description={ t.city }>{ territory.city }</Item>,
    <Item key={3} description={ t.description }>{ territory.description }</Item>,
    <Item key={4} description={ t.numberOfHouseholders }>{ territory.householders.length  }</Item>,
  ];

  if (territory.currentAssignment) {
    main.push(<Item key={5} description={ t.currentAssignee }>{ territory.currentAssignment.assigneeName  }</Item>);
    main.push(<Item key={6} description={ t.dueDate }><Date>{ territory.currentAssignment.returnDate  }</Date></Item>);
  }

  const assignmentsToggler = <ContentToggler openText={ t.hideAssignments } closedText={ t.showAssignments } open={ false }>
    <TerritoryAssignments assignments={territory.assignments} />
  </ContentToggler>;

  const last = territory.householders.length - 1;

  const householdersToggler = <ContentToggler openText={ t.hideHouseholders } closedText={ t.showHouseholders } open={ true }>
    <Row>
      <Col xs= { 12 }>
        { newHouseholderButton({ territory, classes: styles.floatRight }) }
      </Col>
      <Col xs= { 12 }> <Separator /> </Col>
    </Row>

    {
      territory.householders.map((householder, index) => {
        let separator = index !== last;

        return <HouseholderItem key={ householder.id } householder={ householder } separator={ separator } onDelete={ householderDeleteCallback }/>;
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
    this.reload = this.reload.bind(this);
  }

  componentWillMount() {
    this.reload();
  }

  reload() {
    fetchTerritory(this.slug, (territory) => {
      this.setState({territory, loading: false});
    });
  }

  render() {
    const territory = this.state.territory;

    if (!territory) {
      return <div></div>;
    }

    const householderDeleteCallback = this.reload;
    const left  = renderActions({ territory });
    const right = renderTerritoryView({ territory, householderDeleteCallback });

    return <LoaderOrContent loading={ this.state.loading }>
        <LeftRightFrame leftComponent={ left } rightComponent={ right }/>
      </LoaderOrContent>;
  }
}
