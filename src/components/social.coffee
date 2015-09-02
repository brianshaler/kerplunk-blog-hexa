_ = require 'lodash'
React = require 'react'

{
  a
  div
  li
  span
  ul
} = React.DOM


module.exports = React.createFactory React.createClass
  render: ->
    console.log 'socialLinks', @props.globals.public.blog.socialLinks
    socialLinks = @props.globals.public.blog.socialLinks
    # Instagram: 'http://instagram.com/brianshaler'
    # Twitter: 'http://twitter.com/brianshaler'

    div
      className: 'social-links'
    ,
      ul
        id: 'menu-social-links'
        className: 'menu'
      , _.map socialLinks, (socialLink, index) =>
        li
          key: "social-link-#{index}"
          className: 'menu-item menu-item-type-custom menu-item-object-custom'
        ,
          a
            href: socialLink
          ,
            span
              className: 'screen-reader-text'
            , index
