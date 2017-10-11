import React, { Component } from 'react';
import Button from 'react-bootstrap/lib/Button';

export default class extends Component {
  static defaultProps = {
    bsStyle: 'primary',
    loading: true,
    loadingText: null,
    asyncAction: () => { console.log('no action given')  }
  };

  text() {
    if (this.props.loading && this.props.loadingText) {
      return this.props.loadingText;
    }

    return this.props.children;
  }

  dispatchIfNotLoading(event) {
    if (!this.props.loading) {
      this.props.asyncAction(event);
    }
  }

  render() {
    const { loadingText, loading, asyncAction, ...otherProps } = this.props;

    return (
      <Button
        {...otherProps}
        bsStyle={ this.props.bsStyle }
        disabled={ this.props.loading }
        onClick={ event => this.dispatchIfNotLoading(event) }
      > {this.text()} </Button>
    );
  }
}
