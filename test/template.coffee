celles = require ".."
sinon = require "sinon"
chai = require "chai"


chai.use require "sinon-chai"
expect = chai.expect


describe "celles.template.TemplateCell", ->
  describe "::constructor", ->
    it "should calculate value", ->
      cell = celles.cell 1
      templateCell = celles.template prop: cell
      expect(templateCell.value).to.eql prop: 1

    it "should subscribe to cells", ->
      cell = celles.cell 1
      templateCell = celles.template prop: cell
      cell.set 2
      expect(templateCell.value).to.eql prop: 2

    it "should trigger callbacks only if property changed", ->
      callback = sinon.spy()
      cell = celles.cell 0
      templateCell = celles.template prop: cell
      templateCell.onChange callback
      expect(callback).to.be.not.called
      cell.triggerChange()
      expect(callback).to.be.not.called
