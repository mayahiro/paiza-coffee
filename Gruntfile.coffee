path = require 'path'

module.exports = (grunt) ->
  "use strict"

  grunt.initConfig
    coffeelint:
      options:
        max_line_length:
          level: 'warn'
    simplemocha:
      options:
        ui: 'bdd'
        reporter: 'tap'
    esteWatch:
      options:
        dirs: [
          'paiza-*/'
        ]
        livereload:
          enabled: no
      'coffee': (filepath) ->
        dir = path.dirname filepath

        files = [
          expand: yes
          src: filepath
          ext: '.js'
        ]

        grunt.config 'coffee.options.bare', yes
        grunt.config 'coffee.watchCompile.files', files

        grunt.config 'coffeelint.watchLint.files', files

        grunt.config 'concat.watchConcat.src', ['comment_start.js', filepath, 'comment_end.js', filepath.replace('.coffee', '.js')]
        grunt.config 'concat.watchConcat.dest', "#{dir}/concat.js"

        grunt.config 'simplemocha.watchMocha.src', "#{dir}/test/*.coffee"

        # clear cache
        for fp in Object.keys require.cache
          delete require.cache[fp] if fp.indexOf('node_modules') is -1

        ['coffee:watchCompile', 'coffeelint:watchLint', 'concat:watchConcat', 'simplemocha:watchMocha']

  grunt.loadNpmTasks 'grunt-este-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-simple-mocha'

  grunt.registerTask 'default', ['esteWatch']
