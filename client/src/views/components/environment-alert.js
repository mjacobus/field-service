import React, {Component} from 'react';
import style from './environment-alert.css';

export default class EnvironmentAlert extends Component {
  static defaultProps = {
    message: 'This is a test environment. Uset it as you wish.'
  };

  isDevelopmentMode() {
    return !!window.location.href.match(/localhost|staging/);
  }

  render() {
    return this.isDevelopmentMode() && <p className={style.envAlert}>{this.props.message}</p>
  }
}
