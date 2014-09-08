LiquidEngine = require "./liquid-ext"
Q = require "q"
fs = require "fs"
Path = require "path"
grunt = require "grunt"

plugin = ->
  engine = null
  partials = {}

  init = (options) ->
    engine = new LiquidEngine

  compile = (src, options) ->
    engine.extParse src, (name, cb) ->
      if name of partials
        cb null, partials[name]
      else
        cb new Error("Unknown partial: #{name}. Known: #{Object.keys(partials)}")

  ensureCompiled = (template, options) ->
    if typeof template is "string"
      compile template, options
    else
      template

  render = (template, options) ->
    ensureCompiled(template, options).then (template) ->
      template.render options

  registerFunctions = (helperFunctions) ->
    engine.registerFilters helperFunctions

  registerHelper = (helperName, helper) ->
    o = {}
    o[helperName] = helper
    registerFunctions o

  registerPartial = (name, content) ->
    partials[name] = content

  return {
    init: init

    compile: (src, options, callback) ->
      compile(arguments...).nodeify callback

    render: (template, options, callback) ->
      render(arguments...).nodeify callback

    registerFunctions: registerFunctions
    registerHelper: registerHelper
    registerPartial: registerPartial
    liquid: LiquidEngine
  }

module.exports = exports = plugin()
