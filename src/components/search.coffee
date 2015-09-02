React = require 'react'

{
  div
  form
  input
  label
  span
} = React.DOM

module.exports = React.createFactory React.createClass
  render: ->
    div
      className: 'search-wrapper'
    ,
      form
        onSubmit: @dont
      ,
        label null,
          span
            className: 'screen-reader-text'
          , 'Search for:'
          input
            type: 'search'
            className: 'search-field'
            placeholder: 'Search ...'
            name: 'search'
