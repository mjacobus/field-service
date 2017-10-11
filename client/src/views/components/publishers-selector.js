import React, { Component } from 'react';
import routes from '../../api-routes';
import Ajax from '../../utils/ajax-helper';
import hashToArray from '../../utils/hash-to-array';

export default class extends Component {
  static defaultProps = {
    size: 10,
    multiple: true,
    onCollectionChange: () => { console.log('no onCollectionChange given') },
    name: 'publisher_ids[]'
  };

  constructor(props) {
    super(props);
    this.state = { options: [] };
    this.selectedIds = [];
  }

  componentWillMount() {
    const url = routes.publishers.list();

    Ajax.getJson(url).then((response) => {
      this.setState({ options: response.data });
    });
  }

  options() {
    return this.state.options;
  }

  renderOption(option) {
    return <option key={ option.id } value={ option.id } >{ option.name }</option>;
  }

  size() {
    if (this.props.multiple) {
      return this.props.size;
    }

    return 1;
  }

  render() {
    const toggle = (event)  => {
      const selectedValues = hashToArray(event.target.options)
        .filter(o => o.selected).map(o => o.value);

      this.props.onCollectionChange(selectedValues);
    };

    const {onCollectionChange, ...otherProps} = this.props;

    return (
      <select
        {...otherProps}
        size={this.size()}
        name={ this.props.name }
        onChange={ toggle }
        multiple={ this.props.multiple }
      > { this.options().map(this.renderOption) }
      </select>
    );
  }
}
