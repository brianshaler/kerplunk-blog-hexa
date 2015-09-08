React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  getDefaultProps: ->
    show: false

  getInitialState: ->
    status: 0
    showing: false
    animationStartTime: 0
    animationDuration: 200
    animateFrom: 0
    animateTo: 0
    animating: false
    height: 100

  componentDidMount: ->
    @setState
      height: @refs.contents.getDOMNode().offsetHeight

  componentDidUpdate: ->
    animateTo = if @props.show then 1 else 0
    height = @refs.contents.getDOMNode().offsetHeight
    if animateTo != @state.status and animateTo != @state.animateTo
      @setState
        height: if height > 0 then height else @state.height
        animationStartTime: Date.now()
        animateFrom: @state.status
        animateTo: animateTo
        animating: true
    else if height != @state.height
      @setState
        height: height
    @timeout = setTimeout =>
      @animate()
    , 1

  animate: ->
    {status, animateFrom, animateTo, animationStartTime, animationDuration} = @state
    return unless @isMounted()
    clearTimeout @timeout
    return if status == animateTo
    p = (Date.now() - animationStartTime) / animationDuration
    p = 1 if p > 1
    p = 0.5 + 0.5 * Math.sin -Math.PI / 2 + Math.PI * p
    @setState
      status: animateFrom + (animateTo - animateFrom) * p
      animating: p < 1
    return unless p < 1
    # window?.requestAnimationFrame =>
    #   @animate()
    @timeout = setTimeout =>
      @animate()
    , 1

  render: ->
    DOM.div
      id: "#{@props.name}-toggle-nav"
      className: 'panel'
      style:
        display: ('block' if @state.status > 0)
        overflow: ('hidden' if @state.animating)
        height: ("#{@state.height * @state.status}px" if @state.animating)
        margin: (0 if @state.animating)
        padding: (0 if @state.animating)
    ,
      DOM.div
        ref: 'contents'
      , @props.contents
