React = require 'react'

{
  a
  div
  li
  nav
  ul
} = React.DOM

module.exports = React.createFactory React.createClass
  render: ->
    nav
      id: 'site-navigation'
      className: 'main-navigation'
      role: 'navigation'
    ,
      a
        className: 'skip-link screen-reader-text'
        href: '#content'
      , 'Skip to content'
      div
        className: 'menu'
      ,
        ul null,
          li
            className: 'current_page_item'
          ,
            a
              href: @props.blogSettings.baseUrl
            , 'Home'
