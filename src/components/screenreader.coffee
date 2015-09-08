React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    DOM.span
      className: 'screen-reader-text'
    , @props.children
