module.exports = (System) ->
  globals:
    public:
      blog:
        themes:
          'kerplunk-blog-hexa':
            name: 'kerplunk-blog-hexa'
            displayName: 'Hexa Theme'
            components:
              post: 'kerplunk-blog-hexa:showPost'
              posts: 'kerplunk-blog-hexa:showPosts'
              layout: 'kerplunk-blog-hexa:layout'
