React = require 'react'

{
  span
} = React.DOM

module.exports = React.createFactory React.createClass
  render: ->
    span
      className: 'screen-reader-text'
    , @props.children
