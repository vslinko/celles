loadGruntTasks = require "load-grunt-tasks"


module.exports = (grunt) ->
  loadGruntTasks grunt

  grunt.initConfig
    mochaTest:
      options:
        reporter: "spec"
      all:
        src: [
          "test/*.coffee"
        ]
    watch:
      test:
        files: [
          "lib/*.coffee"
          "test/*.coffee"
        ]
        tasks: ["test"]

  grunt.registerTask "test", "mochaTest"

  grunt.registerTask "default", [
    "test"
    "watch"
  ]
