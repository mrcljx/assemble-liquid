Liquid = require "./liquid-ext"
Q = require "q"
fs = require "fs"
Path = require "path"
grunt = require "grunt"

plugin = ->
  init = (options) ->
    # no setup needed for now
    
  compile = (src, options) ->
    Liquid.Template.extParse src, (layout, cb) ->
      layoutSources = Path.join options.layoutdir, "#{layout}.liquid"
      layoutSource = grunt.file.expand(layoutSources)[0]
      Q(layoutSource).then(grunt.file.read).nodeify cb
  
  ensureCompiled = (template, options) ->
    if typeof template is "string"
      compile template, options
    else
      template

  render = (template, options) ->
    ensureCompiled(template, options).then (template) ->
      template.render options

  registerFunctions = (helperFunctions) ->
    Liquid.Template.registerFilter helperFunctions

  registerHelper = (helperName, helper) ->
    o = {}
    o[helperName] = helper
    registerFunctions o

  return {
    init: init
  
    compile: (src, options, callback) ->
      compile(arguments...).nodeify callback

    render: (template, options, callback) ->
      render(arguments...).nodeify callback

    registerFunctions: registerFunctions
    registerHelper: registerHelper
    # registerPartial is not supported for now
    liquid: Liquid
  }

module.exports = exports = plugin()