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
