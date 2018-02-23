import React, { Component } from 'react';
import routes from '../../../api-routes';
import Ajax from '../../../utils/ajax-helper';
import Select from '../../components/select';

const fetchOptions = (callback, onlyOverseers = false) => {
  const url = routes.publishers.index();

  Ajax.getJson(url).then((response) => {
    const options = response.data.map((option) => {
      if (onlyOverseers && !option.overseer) {
        return null;
      }

      return { value: option.id, label: option.name };
    }).filter((option) => option !== null);

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
    }, this.props.overseers);
  }

  render() {
    let props = this.props;
    const options = this.state.options;
    props = {...props, options};
    return <Select {...props} />;
  }
};
