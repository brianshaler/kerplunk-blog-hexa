React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    DOM.nav
      id: 'site-navigation'
      className: 'main-navigation'
      role: 'navigation'
    ,
      DOM.a
        className: 'skip-link screen-reader-text'
        href: '#content'
      , 'Skip to content'
      DOM.div
        className: 'menu'
      ,
        DOM.ul null,
          DOM.li
            className: 'current_page_item'
          ,
            DOM.a
              href: @props.blogSettings.baseUrl
            , 'Home'
