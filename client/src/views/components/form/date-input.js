import React, { Component } from 'react';
import DatePicker from 'react-datepicker';
import moment from 'moment';

import Block from '../input-block';
import Label from '../label';
import Errors from '../input-errors';

import 'react-datepicker/dist/react-datepicker-cssmodules.css';

export default class DateInput extends Component {
  static defaultProps = {
    outputFormat: 'YYYY-MM-DD',
    dateFormat: "DD/MM/YYYY"
  };

  constructor(props) {
    super(props)
    this.state = { startDate: null };
    this.handleChange = this.handleChange.bind(this);
    this.onChange = this.props.onChange.bind(this);
    this.handleOnBlur = this.handleOnBlur.bind(this);
  }

  handleOnBlur(event) {
    let newDate = moment(event.target.value, this.props.dateFormat);

    if (!newDate.isValid()) {
      this.handleChange(null);
    }
  }

  handleChange(date) {
    const { name } = this.props;
    let value = null;

    if (date) {
      value = moment(date).format(this.props.outputFormat);
    }

    this.setState({ startDate: date });
    this.onChange({ target: { name, value } });
  }

  render() {
    const { errors, name, label } = this.props;

    let input = <DatePicker
      name={ name }
      dateFormat={this.props.dateFormat}
      selected={ this.state.startDate }
      isClearable={ true }
      onChange={ this.handleChange }
      placeholderText={ this.props.dateFormat }
      onBlur={ this.handleOnBlur }
    />;

    if (label) {
      input = <div><Label>{label}</Label>{input}</div>;
    }

    const errorElement = <Errors errors={ errors } />;

    return <Block>{input}{errorElement}</Block>;
  }
}
