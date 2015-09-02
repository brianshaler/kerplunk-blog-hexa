React = require 'react'

{
  aside
  div
  h1
} = React.DOM

module.exports = React.createFactory React.createClass
  render: ->
    div
      className: 'widget-area'
    ,
      aside
        className: 'widget'
      ,
        h1
          className: 'widget-title'
        , @props.name
        @props.contents
