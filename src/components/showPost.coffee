_ = require 'lodash'
moment = require 'moment'
React = require 'react'

ScreenReader = require './screenreader'
PostHeader = require './postHeader'
PostMeta = require './postMeta'

{DOM} = React

module.exports = React.createFactory React.createClass
  render: ->
    RenderPostContent = @props.getComponent 'kerplunk-blog:renderPostContent'

    postClass = if /<img/.test @props.post.body
      'format-image'
    else
      'format-post'

    DOM.div null,
      DOM.article
        id: "post-#{@props.post._id}"
        className: "hentry #{postClass}"
      ,
        PostHeader
          postTypeUrl: @props.buildUrl "/posts/type/#{@props.postType}"
          pushState: @props.pushState
          post: @props.post

        # CONTENT
        DOM.div
          className: 'entry-content'
        ,
          RenderPostContent _.extend {}, @props, @state

          PostMeta
            author: @props.post.author
            authorUrl: @props.buildUrl "/posts/author/#{@props.post.author}"
            createdAt: moment.utc(@props.post.createdAt).format('llll')
            isUser: @props.isUser
            permalink: @props.permalink
            postId: @props.post._id
            tags: @props.post.tags

          # DOM.div
          #   className: 'page-links'
          #   style:
          #     display: 'none'
          # ,
          #   DOM.span
          #     className: 'active-link'
          #   , '<- previous'
          #   DOM.span
          #     className: 'active-link'
          #   , 'next ->'
      if @props.previousPost or @props.nextPost
        DOM.nav
          className: 'navigation post-navigation'
          role: 'navigation'
        ,
          DOM.h1
            className: 'screen-reader-text'
          , 'Post navigation'
          DOM.div
            className: 'nav-links'
          ,
            DOM.div
              className: 'nav-previous'
            ,
              DOM.a
                href: @props.previousPost
              , ScreenReader null, 'Previous post'
            DOM.div
              className: 'nav-next'
            ,
              DOM.a
                href: @props.nextPost
              , ScreenReader null, 'Next post'
      else
        null
