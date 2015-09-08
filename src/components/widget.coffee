React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    DOM.div
      className: 'widget-area'
    ,
      DOM.aside
        className: 'widget'
      ,
        DOM.h1
          className: 'widget-title'
        , @props.name
        @props.contents
