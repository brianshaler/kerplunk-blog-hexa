React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    DOM.div
      className: 'search-wrapper'
    ,
      DOM.form
        onSubmit: @dont
      ,
        DOM.label null,
          DOM.span
            className: 'screen-reader-text'
          , 'Search for:'
          DOM.input
            type: 'search'
            className: 'search-field'
            placeholder: 'Search ...'
            name: 'search'
