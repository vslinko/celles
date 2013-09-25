celles = require ".."
sinon = require "sinon"
chai = require "chai"


chai.use require "sinon-chai"
expect = chai.expect


describe "celles.BaseCell", ->
  describe "::constructor", ->
    it "should not have callbacks", ->
      cell = new celles.BaseCell
      expect(cell).to.have.property "callbacks"
      expect(cell.callbacks.change).to.have.length 0

  describe "::onChange", ->
    it "should remember callback", ->
      cell = new celles.BaseCell
      callback = sinon.spy()
      cell.onChange callback
      expect(cell.callbacks.change).to.have.length 1
      expect(callback).to.be.not.called

  describe "::onError", ->
    it "should remember callback", ->
      cell = new celles.BaseCell
      callback = sinon.spy()
      cell.onError callback
      expect(cell.callbacks.error).to.have.length 1
      expect(callback).to.be.not.called

  describe "::subscribe", ->
    it "should remember callback and trigger with current value", ->
      cell = new celles.BaseCell
      callback = sinon.spy()
      cell.value = 123
      cell.error = new Error
      cell.subscribe callback
      expect(cell.callbacks.change).to.have.length 1
      expect(callback).to.be.calledOnce
      expect(callback).to.be.calledWith cell.value, cell.error

  describe "::triggerChange", ->
    it "should trigger all callbacks", ->
      cell = new celles.BaseCell
      callback = sinon.spy()
      cell.onChange callback
      cell.triggerChange()
      expect(callback).to.be.calledOnce
      expect(callback).to.be.calledWith cell.value

  describe "::triggerError", ->
    it "should trigger all callbacks", ->
      cell = new celles.BaseCell
      callback = sinon.spy()
      cell.onError callback
      cell.error = new Error
      cell.triggerError()
      expect(callback).to.be.calledOnce
      expect(callback).to.be.calledWith null, cell.error
