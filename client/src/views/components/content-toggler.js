import React, {Component} from 'react';
import styles from './content-toggler.css';
import Button from './button';

export default class ContentToggler extends Component {
  static defaultProps = {
    boxContent: !false,
    open: false,
    openText: 'Hide',
    closedText: 'Show',
  }

  constructor(props) {
    super(props);
    const open = this.props.open;
    this.state = { open };
    this.toggle = this.toggle.bind(this);
    this.classNames = this.classNames.bind(this);
  }

  toggle() {
    const open = !this.state.open;
    this.setState({ open });
  }

  text() {
    return this.state.open ? this.props.openText : this.props.closedText;
  }

  icon() {
    return this.state.open ? <span>&#8673;</span> : <span>&#8675;</span>
  }

  classNames(name) {
    const open = this.state.open;
    const otherName = [name, open  ? 'Open' : 'Closed'].join('');
    return [styles[name], styles[otherName]].join(' ');
  }

  render() {
    let contentClasses = [this.classNames('contentContainer')];
    let containerClasses = [this.classNames('container')];

    if (this.props.boxContent) {
      contentClasses.push(styles.boxedContentContainer);
      containerClasses.push(styles.boxedContainer);
    }

    return <div className={ containerClasses.join(' ') }>
      <div className={ this.classNames('buttonContainer') }>
        <Button bsStyle='default' className={ styles.button } onClick={this.toggle}>
          <span className={styles.text}> { this.text() }</span>
          <span className={ styles.icon }> { this.icon() }</span>
        </Button>
      </div>

      <div className={ contentClasses.join(' ') }>{ this.state.open && this.props.children }</div>
    </div>;
  }
};
