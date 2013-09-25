celles = require ".."
sinon = require "sinon"
chai = require "chai"


chai.use require "sinon-chai"
expect = chai.expect


describe "celles.BaseCell", ->
  describe "::constructor", ->
    it "should subscribe to callback", (callback) ->
      cell = celles.callback (callback) ->
        setTimeout ->
          callback 123
        , 100
      expect(cell.value).to.equal null
      cell.onChange ->
        expect(cell.value).to.equal 123
        callback()

    it "should set error if callback throws", ->
      cell = celles.callback (callback) ->
        throw new Error
      expect(cell.error).to.be.instanceOf Error
