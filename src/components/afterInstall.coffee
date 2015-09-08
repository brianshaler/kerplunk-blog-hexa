React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  getInitialState: ->
    status: null

  setTheme: (e) ->
    e.preventDefault()
    console.log 'set theme behind the scenes'
    @setState
      status: 'loading'
    setTimeout =>
      return unless @isMounted()
      @setState
        status: 'error'
    , 1500

  render: ->
    disabled = true if @state.status == 'loading'
    [buttonClass, buttonText] = if @state.status?
      ['default', 'Processing']
    else
      ['info', 'SetTheme']

    DOM.div null,
      DOM.p null,
        'Would you like to set Hexa as your blog theme? '
        if @state.status == 'set'
          DOM.strong null, 'Your theme has been set to Hexa!'
        else if @state.status == 'error'
          DOM.strong null,
            'An error occurred. Set your theme in your '
            DOM.a
              href: '/admin/blog'
              onClick: @props.pushState
            , 'Blog Settings'
            ' instead.'
        else
          DOM.a
            href: '/admin/p2p/connect'
            onClick: @setTheme
            className: "btn btn-sm btn-#{buttonClass}"
            disabled: true if disabled == true
          , buttonText
