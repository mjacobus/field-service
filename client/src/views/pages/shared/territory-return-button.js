import React from 'react';
import {Row, Col} from 'react-bootstrap';

import Button from '../../components/button';
import Form from '../../components/rails-form';
import Label from '../../components/label';
import Fieldset from '../../components/fieldset';

import styles from './territory-return-button.css';

import t from '../../../translations';

const today = new Date();
let defaultDate = [
  today.getFullYear(),
  today.getMonth() + 1,
  today.getDate(),
];

if (defaultDate[2].toString().length === 1) {
  defaultDate[2] = "0" + defaultDate[2].toString();
}

defaultDate = defaultDate.join('-');

export default class TerritoryReturnButton extends React.Component {
  constructor(props) {
    super(props);
    this.state = { open: false };
    this.openForm = this.openForm.bind(this);
    this.closeForm = this.closeForm.bind(this);
  }

  openForm() {
    this.setState({ open: true });
  }

  closeForm() {
    this.setState({ open: false });
  }

  renderForm() {
    const { territory, ...otherProps } = this.props;
    const href = territory.links.return;

    let content = <div>
      <Fieldset className={ styles.fieldset }>
      <Form action={ href } method="delete">
        <input type="hidden" name="complete" value="0" />
        <input type="hidden" name="territory_id" value={ territory.id } />

        <Row>
          <Col xs={12}>
            <Label> { t.territoryCompletelyWorked } </Label>
          </Col>
          <Col xs={12}>
            <Label className={ styles.label }>&nbsp;<input className={ styles.checkbox } type="radio" value="0" name="complete"  />{ t.no }</Label>
            <Label className={ styles.label }>&nbsp;<input className={ styles.checkbox } type="radio" value="1" name="complete" />{ t.yes }</Label>
          </Col>
        </Row>

        <Row>
          <Col xs={12}>
            <Label>
              { t.returnedAt }
              <input type="text" name="return_date" defaultValue={ defaultDate } placeholder="YYYY-MM-DD" />
            </Label>
          </Col>
        </Row>

        <Row>
          <Col xs={12}> <Button type="submit" {...otherProps}>{ t.confirmReturn }</Button></Col>
        </Row>

      </Form>
      <Button {...otherProps} onClick={ this.closeForm } >{ t.cancel }</Button>
    </Fieldset>
    </div>;

    return content;
  }

  render() {
    const { href, ...otherProps } = this.props;
    let content = <Button {...otherProps} onClick={ this.openForm } >{ t.returnTerritory }</Button>;

    if (this.state.open) {
       content = this.renderForm();
    }

    return content;
  }
}
