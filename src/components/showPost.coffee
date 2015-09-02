_ = require 'lodash'
moment = require 'moment'
React = require 'react'
ReactMarkdownName = 'react-markdown'

ScreenReader = require './screenreader'

ReactMarkdownClass = ReactMarkdown ? require ReactMarkdownName
ReactMarkdownComponent = React.createFactory ReactMarkdownClass

{
  a
  article
  div
  footer
  h1
  h3
  header
  nav
  p
  span
  time
} = React.DOM

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

  header: ->
    typeLink = if @props.post.type
      a
        className: 'entry-format'
        href: @props.buildUrl "/posts/type/#{@props.post.type}"
        title: "All #{@props.post.type} posts"
      ,
        ScreenReader null, @props.post.type
    else
      span
        className: 'entry-format'
      , ''

    header
      className: 'entry-header'
    ,
      typeLink
      h1
        className: 'hentry-title'
      ,
        a
          href: @props.post.permalink
          title: @props.post.title
          rel: 'bookmark'
        , @props.post.title

  content: ->
    div
      className: 'entry-content'
    ,
      ReactMarkdownComponent
        source: if @state.truncate == true
          @state.truncatedBody
        else
          @state.body
        escapeHtml: true
      if @state.truncate
        p
          className: 'entry-meta continue-reading'
        ,
          a
            href: @props.post.permalink
            onClick: @onExpand
          , 'Continue reading'
      else
        null
      @meta()

      # div
      #   className: 'page-links'
      #   style:
      #     display: 'none'
      # ,
      #   span
      #     className: 'active-link'
      #   , '<- previous'
      #   span
      #     className: 'active-link'
      #   , 'next ->'

  meta: ->
    createdAt = moment.utc @props.post.createdAt
      .format 'llll'
    footer
      className: 'entry-meta'
    ,
      span
        className: 'post-date'
      ,
        a
          href: @props.post.permalink
          title: createdAt
          rel: 'bookmark'
        ,
          time
            className: 'entry-date'
            dateTime: createdAt
          ,
            createdAt
      span
        className: 'byline'
      ,
        span
          className: 'author vcard'
        ,
          a
            className: 'url fn n'
            href: @props.buildUrl "/posts/author/#{@props.post.author}"
            title: "View all posts by #{@props.post.author}"
            rel: 'author'
          , @props.post.author
      if @props.post.tags?.length > 0
        span
          className: 'tags-links'
        , ''
      else
        null
      if @props.isUser
        span
          className: 'edit-link'
        ,
          a
            href: "/admin/blog/edit/#{@props.post._id}"
          , 'Edit'
      else
        null

  render: ->
    postClass = if /<img/.test @props.post.body
      'format-image'
    else
      'format-post'

    div null,
      article
        id: "post-#{@props.post._id}"
        className: "hentry #{postClass}"
      ,
        @header()
        @content()
      if @props.previousPost or @props.nextPost
        nav
          className: 'navigation post-navigation'
          role: 'navigation'
        ,
          h1
            className: 'screen-reader-text'
          , 'Post navigation'
          div
            className: 'nav-links'
          ,
            div
              className: 'nav-previous'
            ,
              a
                href: @props.previousPost
              , ScreenReader null, 'Previous post'
            div
              className: 'nav-next'
            ,
              a
                href: @props.nextPost
              , ScreenReader null, 'Next post'
      else
        null
