_ = require 'lodash'
React = require 'react'

Panel = require './panel'
ScreenReader = require './screenreader'

Header = require './header'
Footer = require './footer'
Menu = require './menu'
Search = require './search'
Social = require './social'
Widgets = require './widgets'

{DOM} = React

module.exports = React.createFactory React.createClass
  getInitialState: ->
    navShow: ''

  buildUrl: (relPath) ->
    if @props.blogSettings.baseUrl == '/'
      relPath
    else
      @props.blogSettings.baseUrl + relPath

  toggleNav: (name) ->
    @setState
      navShow: if @state.navShow == name then '' else name

  render: ->
    ContentComponent = @props.getComponent @props.contentComponent

    DOM.div
      className: 'fixed'
    ,
      DOM.link
        rel: 'stylesheet'
        href: '/plugins/kerplunk-blog-hexa/css/style.css'
        media: 'all'
      DOM.link
        rel: 'stylesheet'
        href: '/plugins/kerplunk-blog-hexa/css/genericons/genericons.css'
        media: 'all'
      DOM.div
        className: 'home blog mp6 highlander-enabled highlander-light'
      ,
        DOM.div
          className: 'hfeed site'
          id: 'page'
        ,
          Panel
            name: 'menu'
            show: @state.navShow == 'menu'
            contents: Menu _.extend {}, @props
          Panel
            name: 'social-links'
            show: @state.navShow == 'social-links'
            contents: Social
              socialLinks: @props.globals.public.blog.socialLinks
          Panel
            name: 'sidebar'
            show: @state.navShow == 'sidebar'
            contents: Widgets()
          Panel
            name: 'search'
            show: @state.navShow == 'search'
            contents: Search()
          Header
            blogSettings: @props.blogSettings
            toggleNav: @toggleNav
            pushState: @props.pushState
          DOM.div
            id: 'content'
            className: 'site-content'
          ,
            ContentComponent _.extend {}, @props,
              key: @props.currentUrl
              buildUrl: @buildUrl
          Footer()
