React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    DOM.footer
      id: 'colophon'
      className: 'site-footer'
      role: 'contentinfo'
    ,
      DOM.div
        className: 'site-info'
      ,
        DOM.a
          href: '#'
        , 'Footer link'
        DOM.span
          className: 'sep'
        , ' | '
        DOM.a
          href: '#'
        , 'Based on Hexa Theme by WordPress.com'
