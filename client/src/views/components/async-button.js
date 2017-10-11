import React, { Component } from 'react';
import Button from 'react-bootstrap/lib/Button';

export default class extends Component {
  static defaultProps = {
    bsStyle: 'primary',
    loading: true,
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
    const props = this.props;
    return (
      <Button
        {...props}
        bsStyle={ this.props.bsStyle }
        disabled={ this.props.loading }
        onClick={ event => this.dispatchIfNotLoading(event) }
      > {this.text()} </Button>
    );
  }
}
