// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import {Card, CardActions, CardHeader, CardText} from 'material-ui/Card'
import FlatButton from 'material-ui/FlatButton'
import TextField from 'material-ui/TextField';
import baseTheme from 'material-ui/styles/baseThemes/lightBaseTheme'
import getMuiTheme from 'material-ui/styles/getMuiTheme'
import injectTapEventPlugin from 'react-tap-event-plugin'
injectTapEventPlugin()

class Hello extends React.Component {
  constructor(props) {
    super(props)
    this.state = { name: this.props.name }
  }

  updateName(name) {
    this.setState({ name });
  }

  getChildContext() {
    return { muiTheme: getMuiTheme(baseTheme) }
  }

  render() {
    return (
      <Card>
        <CardHeader
          title={this.state.name}
          subtitle="言語やフレームワークをエンジニアだけで自由に変更できます"
          actAsExpander={true}
          showExpandableButton={true}
        />
        // アクション
        <CardActions>
          <FlatButton label="ボタン" />
          <FlatButton label="ボタン" />
          <br />
          <TextField
            hintText="テキスト"
            id="name"
            type="text"
            value={this.state.name}
            onChange={(e) => this.updateName(e.target.value)}
            />
        </CardActions>
        // テキスト
        <CardText expandable={true}>
          ・Ruby 2.4.1 <br />
          ・Rails 5.1.3 <br />
          ・Material-UI <br />
          ・Docker <br />
          ・Kubernetes <br />
        </CardText>
      </Card>
    )
  }
}

Hello.childContextTypes = {
  muiTheme: PropTypes.object.isRequired
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello />,
    document.body.appendChild(document.createElement('div')),
  )
})
