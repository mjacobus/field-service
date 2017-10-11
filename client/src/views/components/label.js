import React, { Component } from 'react';
import styles from './label.css';

export default class Label extends Component {
  static defaultProps = {
    loading: true,
    size: 50,
  };

  render() {
    return (<label className={styles.label}>{ this.props.children }</label>);
  }
}

