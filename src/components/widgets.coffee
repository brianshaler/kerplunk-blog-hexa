_ = require 'lodash'
React = require 'react'

Widget = require './widget'

{
  div
  form
  input
  label
  span
} = React.DOM

module.exports = React.createFactory React.createClass
  render: ->
    widgets = [
      {
        name: 'Comments'
        content: div null, 'hi'
      }
      {
        name: 'Tags'
        content: div null, 'hello'
      }
    ]

    div
      className: 'widget-areas'
    , _.map widgets, (widget) ->
      Widget
        key: "widget-#{widget.name}"
        name: widget.name
        contents: widget.content
