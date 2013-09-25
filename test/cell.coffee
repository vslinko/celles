celles = require ".."
sinon = require "sinon"
chai = require "chai"


chai.use require "sinon-chai"
expect = chai.expect


describe "celles.cell.Cell", ->
  describe "::constructor", ->
    it "should set initial value", ->
      cell = celles.cell "test"
      expect(cell.value).to.equal "test"

  describe "::set", ->
    it "should change value", ->
      cell = celles.cell()
      callback = sinon.spy()
      cell.onChange callback
      cell.set "test"
      expect(callback).to.be.calledOnce
      expect(callback).to.be.calledWith "test"

    it "should reset error", ->
      cell = celles.cell()
      cell.error = new Error
      cell.set "test"
      expect(cell.error).to.equals null

    it "should not trigger callback if new value equals previous value", ->
      cell = celles.cell "test"
      callback = sinon.spy()
      cell.onChange callback
      cell.set "test"
      expect(callback).to.be.not.called

  describe "::throw", ->
    it "should reset value", ->
      cell = celles.cell 123
      cell.throw new Error
      expect(cell.value).to.equals null

    it "should trigger error", ->
      cell = celles.cell()
      callback = sinon.spy()
      cell.onError callback
      cell.throw new Error
      expect(callback).to.be.called
