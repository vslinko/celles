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

    it "should subscribe to cells recursively", ->
      cell = celles.cell 1
      templateCell = celles.template level1: level2: cell
      cell.set 2
      expect(templateCell.value).to.eql level1: level2: 2

    it "should subscribe to cells in arrays", ->
      cell = celles.cell 1
      templateCell = celles.template prop: [cell]
      cell.set 2
      expect(templateCell.value).to.eql prop: [2]

      cell = celles.cell 1
      templateCell = celles.template [cell]
      cell.set 2
      expect(templateCell.value).to.eql [2]

    it "should trigger callbacks only if property changed", ->
      callback = sinon.spy()
      cell = celles.cell 0
      templateCell = celles.template prop: cell
      templateCell.onChange callback
      expect(callback).to.be.not.called
      cell.triggerChange()
      expect(callback).to.be.not.called

    it "should throw error if template is cell", ->
      cell = celles.cell 0
      expect(-> celles.template cell).to.throw Error

    it "should throw error if template is scalar value", ->
      expect(-> celles.template 1).to.throw Error
