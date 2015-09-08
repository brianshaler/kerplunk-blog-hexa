React = require 'react'

{DOM} = React

ToggleButton = React.createFactory React.createClass
  handleClick: (e) ->
    @props.toggleNav @props.name

  render: ->
    DOM.div
      id: "#{@props.name}-toggle"
      className: 'toggle'
      title: @props.display
      onClick: @handleClick
    ,
      DOM.span
        className: 'screen-reader-text'
      , @props.display

module.exports = React.createFactory React.createClass
  render: ->
    DOM.header
      id: 'masthead'
      className: 'site-header'
      role: 'banner'
    ,
      DOM.div
        className: 'site-header-wrapper'
      ,
        DOM.div
          className: 'site-branding'
        ,
          DOM.h1
            className: 'site-title'
          ,
            DOM.a
              onClick: @props.pushState
              href: @props.blogSettings.baseUrl
              rel: 'home'
            , @props.blogSettings.title
          DOM.h2
            className: 'site-description'
          , @props.blogSettings.tagline
        DOM.div
          className: 'toggles'
        ,
          ToggleButton
            toggleNav: @props.toggleNav
            name: 'menu'
            display: 'Menu'
          ToggleButton
            toggleNav: @props.toggleNav
            name: 'sidebar'
            display: 'Widgets'
          ToggleButton
            toggleNav: @props.toggleNav
            name: 'social-links'
            display: 'Social Links'
          ToggleButton
            toggleNav: @props.toggleNav
            name: 'search'
            display: 'Search'
