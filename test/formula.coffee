celles = require ".."
sinon = require "sinon"
chai = require "chai"


chai.use require "sinon-chai"
expect = chai.expect


describe "celles.formula.FormulaCell", ->
  describe "::constructor", ->
    it "should call formula", ->
      formula = sinon.spy()
      cell = celles.formula [], formula
      expect(formula).to.be.calledOnce

    it "should subscribe to cells", ->
      formula = sinon.spy()
      cell = celles.cell 1
      formulaCell = celles.formula [cell], formula
      expect(formula).to.be.calledOnce
      cell.set 2
      expect(formula).to.be.calledTwice

    it "should trigger callbacks only if value changed", ->
      callback = sinon.spy()
      cell = celles.cell 0
      formulaCell = celles.formula [cell], (cell) ->
        cell % 2
      formulaCell.onChange callback
      expect(callback).to.be.not.called
      cell.set 1
      expect(callback).to.be.calledOnce
      cell.set 3
      expect(callback).to.be.calledOnce

  describe "::calculate", ->
    it "should map cell values", ->
      callback = sinon.spy()
      two = 2
      four = celles.cell 4
      formulaCell = celles.formula [two, four], (two, four) ->
        two + four
      formulaCell.subscribe callback
      expect(callback).to.be.calledWith 6

    it "should trigger error if formula throws", ->
      count = 0
      formula = ->
        count += 1
        throw new Error if count is 2
      cell = celles.formula [], formula
      expect(cell.error).to.equals null
      callback = sinon.spy()
      cell.onError callback
      cell.calculate()
      expect(callback).to.be.calledOnce
