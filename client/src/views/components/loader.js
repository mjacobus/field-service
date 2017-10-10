import React, { Component } from 'react';

class Loader extends Component {
  static defaultProps = { loading: true };

  render() {
    return (
      <p>Loading...</p>
    );
  }
}

export default Loader;
