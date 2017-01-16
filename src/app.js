const Components = {};
Components.App = class extends React::Component {
  name() {
    return 'Adam George';
  }
  render() {
    return React.createElement('div', undefined, `Hello ${this.props.toWhat();}`);;
  }
}