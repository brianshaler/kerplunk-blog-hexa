_ = require 'lodash'
React = require 'react'

Widget = require './widget'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    widgets = [
      {
        name: 'Comments'
        content: DOM.div null, 'hi'
      }
      {
        name: 'Tags'
        content: DOM.div null, 'hello'
      }
    ]

    DOM.div
      className: 'widget-areas'
    , _.map widgets, (widget) ->
      Widget
        key: "widget-#{widget.name}"
        name: widget.name
        contents: widget.content
