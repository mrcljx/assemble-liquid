# assemble-liquid

> Assemble engine plugin for processing Liquid (node-liquid) templates.

See [assemble](http://assemble.io) for documentation.

## Usage

Modify your `assemble`-options in your `Gruntfile` so that `assemble` uses `assemble-liquid` as the engine.

    grunt.initConfig({
      // ...
      
      assemble: {
        options: {
          // ...
          engine: "assemble-liquid"
        },
        site: {
          files: [{
            expand: true,
            cwd: 'src/templates/pages',
            src: ['**/*.liquid'],
            dest: '<%= site.destination %>/'
          }]
        },
      },
      // ...
    }

## To-Do

- Assemble's partials are not supported yet.

## Authors

**Marcel Jackwerth**

+ [http://twitter.com/sirlantis](http://twitter.com/sirlantis)
+ [http://github.com/sirlantis](http://github.com/sirlantis)

## Copyright and license

Copyright 2013 Marcel Jackwerth

[MIT License](LICENSE-MIT)
