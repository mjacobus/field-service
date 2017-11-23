import React, { Component } from 'react';
import {Row, Col} from 'react-bootstrap';
import LeftRightFrame from '../../components/left-right-frame';
import ContentToggler from '../../components/content-toggler';
import Separator from '../../components/separator';
import Date from '../../components/date';
import appRoutes from '../../../app-routes';
import LoaderOrContent from '../../components/loader-or-content';
import Item from '../../components/property-value-label';
import Button from '../../components/button';
import TerritoryAssignments from '../shared/territory-assignments';
import ReturnTerritoryButton from '../shared/territory-return-button';
import Householders from './householders';
import { withRouter } from 'react-router-dom'

import t from '../../../translations';

import styles from '../../../global.css';

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

  const householderProps = {
    householders: territory.householders,
    onDelete: householderDeleteCallback
  };


  const householdersToggler = <ContentToggler openText={ t.hideHouseholders } closedText={ t.showHouseholders } open={ true }>
    <Row>
      <Col xs= { 12 }>
        { newHouseholderButton({ territory, classes: styles.floatRight }) }
      </Col>
      <Col xs= { 12 }> <Separator /> </Col>
    </Row>

    <Householders {...householderProps} />
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
    this.slug = this.props.match.params.slug;
    this.reload = this.reload.bind(this);
    this.onHouseholderDelete = this.onHouseholderDelete.bind(this);
  }

  componentWillMount() {
    this.reload();
  }

  reload() {
    this.props.fetchTerritory(this.slug);
  }

  onHouseholderDelete() {
    this.props.fetchTerritory(this.slug, { cache: false });
  }

  render() {
    const territory = this.props.territory;

    if (!territory) {
      return <div></div>;
    }

    const householderDeleteCallback = this.onHouseholderDelete;
    const left  = renderActions({ territory });
    const right = renderTerritoryView({ territory, householderDeleteCallback });

    return <LoaderOrContent loading={ this.props.loading }>
        <LeftRightFrame leftComponent={ left } rightComponent={ right }/>
      </LoaderOrContent>;
  }
}
