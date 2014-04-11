expect = require('chai').expect

describe "assemble-liquid", ->
  it "exports an engine", ->
    liquid = require "../src/assemble-liquid"
    expect(liquid).not.to.be.null
    expect(liquid).to.have.property "init"
    expect(liquid).to.have.property "liquid"
    
  describe "when initialized", ->
    plugin = null
    
    before ->
      plugin = require "../src/assemble-liquid"
      plugin.init()  
    
    it "allows registration of functions", ->
      expect ->
        plugin.registerFunctions meaning: -> 24
      .not.to.throw(Error)
      
    it "allows registration of helper", ->
      expect ->
        plugin.registerHelper "meaning", 24
      .not.to.throw(Error)