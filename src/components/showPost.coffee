_ = require 'lodash'
moment = require 'moment'
React = require 'react'
ReactMarkdownName = 'react-markdown'

ScreenReader = require './screenreader'
PostHeader = require './postHeader'
PostMeta = require './postMeta'

ReactMarkdownClass = ReactMarkdown ? require ReactMarkdownName
ReactMarkdownComponent = React.createFactory ReactMarkdownClass

{DOM} = React

module.exports = React.createFactory React.createClass
  getInitialState: ->
    truncatedBody = body = @props.post.body

    if @props.truncate
      maxLines = 12
      lines = body.split '\n'
      usedLines = []
      count = 0
      for line in lines
        break if count >= maxLines
        usedLines.push line
        count += 1 + Math.floor line.length / 50
      truncatedBody = usedLines.join '\n'

    truncate: truncatedBody.length != body.length
    truncatedBody: truncatedBody
    body: body

  onExpand: (e) ->
    e.preventDefault()
    @setState
      truncate: false

  render: ->
    CustomComponent = if @props.post.attributes?.componentPath?.length > 0
      console.log 'get component', @props.post.attributes.componentPath
      @props.getComponent @props.post.attributes.componentPath
    else
      false
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
          postType: @props.post.type
          permalink: @props.post.permalink
          title: @props.post.title
          pushState: @props.pushState

        # CONTENT
        DOM.div
          className: 'entry-content'
        ,
          if CustomComponent == false
            ReactMarkdownComponent
              source: if @state.truncate == true
                @state.truncatedBody
              else
                @state.body
              escapeHtml: true
          else
            CustomComponent _.extend {}, @props, @props.post.attributes?.data
          if CustomComponent == false and @state.truncate
            DOM.p
              className: 'entry-meta continue-reading'
            ,
              DOM.a
                href: @props.post.permalink
                onClick: @onExpand
              , 'Continue reading'
          else
            null

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
