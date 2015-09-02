_ = require 'lodash'
moment = require 'moment'
React = require 'react'

Post = require './showPost'

{
  a
  div
  h3
  p
  span
} = React.DOM

module.exports = React.createFactory React.createClass
  render: ->
    div null,
      _.map @props.posts, (post) =>
        Post _.extend {}, @props,
          key: post._id
          post: post
          truncate: true
