module.exports = (grunt) ->

  grunt.loadTasks 'gruntcomponents/tasks'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig

    growl:
      common:
        title: 'COMPLETE!!'
        msg: 'compile done.'
      compass:
        title: 'COMPLETE!!'
        msg: 'compass compiling done.'
      hologram:
        title: 'COMPLETE!!'
        msg: 'hologram compiling done.'

    compass:
      all:
        options:
          config: 'config.rb'
          bundleExec: true
    
    shell:
      hologram:
        options:
          stdout: true
        command: 'bundle exec hologram'

    clean:
      hologram_output: [ 'docs' ]

    watch:
      compass:
        files: [ 'sass/**/*' ]
        tasks: [
          'compass'
          'growl:compass'
        ]
      hologram:
        files: [
          'hologram_config.yml'
          'markdown_renderer.rb'
          'build/css/**/*'
          'templates/**/*'
        ]
        tasks: [
          #'clean:hologram_output'
          'shell:hologram'
          'growl:hologram'
        ]

  grunt.registerTask 'cleanThenHologram', [
    'clean:hologram_output'
    'shell:hologram'
  ]
  grunt.registerTask 'default', [
    'compass'
    'cleanThenHologram'
    'growl:common'
  ]
