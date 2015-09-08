gulp = require 'gulp'
glut = require 'glut'

browserify = require 'browserify'
coffee = require 'gulp-coffee'
coffeeAmdify = require 'glut-coffee-amdify'

header = require 'gulp-header'
footer = require 'gulp-footer'

buffer = require 'vinyl-buffer'
# transform = require 'vinyl-transform'
source = require 'vinyl-source-stream'

# gulp.task 'amdify', ->
#   gulp.src 'public/browserify/*.js'
#   .pipe header '(function() {\n'
#   .pipe footer '\n;\nreturn require("react-markdown");});'
#   .pipe gulp.dest 'public/amd'

gulp.task 'browserify', ->
  b = browserify
    entries: './node_modules/react-markdown/src/react-markdown.js'
    standalone: 'ReactMarkdown'
  b
  # .ignore 'react'
  .bundle()
  .pipe source 'react-markdown.js'
  .pipe buffer()
  # .pipe header 'requirejs(["react"], function (REACT) {\n(function (require, module, define) {\n'
  .pipe header '(function (require, module, define) {\n'
  .pipe footer '\n})();\n'
  .pipe gulp.dest './public/browserify'

glut gulp,
  tasks:
    coffee:
      runner: coffee
      src: 'src/**/*.coffee'
      dest: 'lib'
    components:
      runner: coffeeAmdify
      src: 'src/components/**/*.coffee'
      dest: 'public/components'
    browserifyx:
      deps: ['browserify']
    # browserify:
    #   runner: require 'glut-browserify'
    #   src: 'wtf/tmp.js'
    #   dest: 'tmpb'
    # amdify:
    #   runner: require 'gulp-wrap-amd'
    #   src: [
    #     'node_modules/react-markdown/src/react-markdown.js'
    #     'node_modules/react-markdown/node_modules/commonmark/lib/*.js'
    #     'node_modules/react-markdown/node_modules/commonmark-react-renderer/src/*.js'
    #   ]
    #   dest: 'public/amd'
    assets:
      src: 'assets/**'
      dest: 'public'

gulp = require 'gulp'
glut = require 'glut'

coffee = require 'gulp-coffee'
coffeeAmdify = require 'glut-coffee-amdify'

glut gulp,
  tasks:
    coffee:
      runner: coffee
      src: 'src/**/*.coffee'
      dest: 'lib'
    components:
      runner: coffeeAmdify
      src: 'src/components/**/*.coffee'
      dest: 'public/components'
    assets:
      src: 'assets/**'
      dest: 'public'
