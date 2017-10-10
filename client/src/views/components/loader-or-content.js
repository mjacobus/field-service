import React, { Component } from 'react';
import Loader from './loader';

export default class extends Component {
  static defaultProps = { loading: true };

  render() {
    let classNames = ['loader'];

    if (this.props.loading) {
      classNames.push('loading')
    }

    return (
      <div className={ classNames.join(' ') }>
        { this.props.loading ? <Loader /> : this.props.children}
      </div>
    );
  }
}
