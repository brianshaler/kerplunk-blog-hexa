_ = require 'lodash'
React = require 'react'

Panel = require './panel'
ScreenReader = require './screenreader'

Menu = require './menu'
Search = require './search'
Social = require './social'
Widgets = require './widgets'

{
  a
  div
  footer
  h1
  h2
  header
  link
  nav
  span
} = React.DOM

module.exports = React.createFactory React.createClass
  getInitialState: ->
    navShow: ''

  buildUrl: (relPath) ->
    if @props.blogSettings.baseUrl == '/'
      relPath
    else
      @props.blogSettings.baseUrl + relPath

  button: (name, display) ->
    div
      id: "#{name}-toggle"
      className: 'toggle'
      title: display
      onClick: =>
        @setState
          navShow: if @state.navShow == name then '' else name
    ,
      span
        className: 'screen-reader-text'
      , display

  header: ->
    header
      id: 'masthead'
      className: 'site-header'
      role: 'banner'
    ,
      div
        className: 'site-header-wrapper'
      ,
        div
          className: 'site-branding'
        ,
          h1
            className: 'site-title'
          ,
            a
              href: @props.blogSettings.baseUrl
              rel: 'home'
            , @props.blogSettings.title
          h2
            className: 'site-description'
          , @props.blogSettings.tagline
        div
          className: 'toggles'
        ,
          @button 'menu', 'Menu'
          @button 'sidebar', 'Widgets'
          @button 'social-links', 'Social Links'
          @button 'search', 'Search'

  footer: ->
    footer
      id: 'colophon'
      className: 'site-footer'
      role: 'contentinfo'
    ,
      div
        className: 'site-info'
      ,
        a
          href: '#'
        , 'Footer link'
        span
          className: 'sep'
        , ' | '
        a
          href: '#'
        , 'Based on Hexa Theme by WordPress.com'

  dont: (e) ->
    e.preventDefault()

  render: ->
    div
      className: 'fixed'
    ,
      link
        rel: 'stylesheet'
        href: '/plugins/kerplunk-blog-hexa/css/style.css'
        media: 'all'
      link
        rel: 'stylesheet'
        href: '/plugins/kerplunk-blog-hexa/css/genericons/genericons.css'
        media: 'all'
      div
        className: 'home blog mp6 highlander-enabled highlander-light'
      ,
        div
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
            contents: Social _.extend {}, @props
          Panel
            name: 'sidebar'
            show: @state.navShow == 'sidebar'
            contents: Widgets()
          Panel
            name: 'search'
            show: @state.navShow == 'search'
            contents: Search()
          @header()
          div
            id: 'content'
            className: 'site-content'
          ,
            @props.getComponent(@props.contentComponent) _.extend {key: @props.currentUrl},
              @props
              {buildUrl: @buildUrl}

          @footer()

module.exports.scripts = [
  '/plugins/kerplunk-blog/browserify/react-markdown.js'
]

# ugh.
module.exports
