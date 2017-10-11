import React, { Component } from 'react';
import routes from '../../api-routes';
import Ajax from '../../utils/ajax-helper';
import Select from './select';

const fetchOptions = (callback) => {
  const url = routes.publishers.list();

  Ajax.getJson(url).then((response) => {
    const options = response.data.map((options) => {
      return { value: options.id, label: options.name };
    });

    callback(options);
  });
};

export default class extends Component {
  constructor(props) {
    super(props);
    this.state = { options: [] };
  }

  componentWillMount() {
    fetchOptions((options) => {
      this.setState({options: options});
    });
  }

  render() {
    let props = this.props;
    const options = this.state.options;
    props = {...props, options};
    return <Select {...props} />;
  }
};
