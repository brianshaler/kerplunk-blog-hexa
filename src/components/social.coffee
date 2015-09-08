_ = require 'lodash'
React = require 'react'

{DOM} = React

module.exports = React.createFactory React.createClass
  shouldComponentUpdate: (nextProps, nextState) ->
    nextProps.socialLinks != @props.socialLinks

  render: ->
    # Instagram: 'http://instagram.com/brianshaler'
    # Twitter: 'http://twitter.com/brianshaler'
    console.log 'socialLinks', @props.socialLinks

    DOM.div
      className: 'social-links'
    ,
      DOM.ul
        id: 'menu-social-links'
        className: 'menu'
      , _.map @props.socialLinks, (socialLink, index) =>
        DOM.li
          key: "social-link-#{index}"
          className: 'menu-item menu-item-type-custom menu-item-object-custom'
        ,
          DOM.a
            href: socialLink
          ,
            DOM.span
              className: 'screen-reader-text'
            , index
