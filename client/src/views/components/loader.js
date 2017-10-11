import React, { Component } from 'react';
import loaderImage from './assets/loader.gif';
import styles from './loader.css';

class Loader extends Component {
  static defaultProps = {
    loading: true,
    size: 50,
  };

  render() {
    return (
      <div className={styles.loader}>
        <img height={this.props.size} width={this.props.size}src={loaderImage} alt="Loading..."/>
      </div>
    );
  }
}

export default Loader;
