celles = require ".."
sinon = require "sinon"
chai = require "chai"


chai.use require "sinon-chai"
expect = chai.expect


describe "celles.promise.PromiseCell", ->
  describe "::constructor", ->
    it "should subscribe to promise", (callback) ->
      promise = then: (resolve, reject) ->
        setTimeout ->
          resolve 123
        , 100

      cell = celles.promise promise
      expect(cell.value).to.equal null
      cell.onChange ->
        expect(cell.value).to.equal 123
        callback()

    it "should trigger error if promise throws", (callback) ->
      promise = then: (resolve, reject) ->
        setTimeout ->
          reject new Error
        , 100

      cell = celles.promise promise
      expect(cell.error).to.equal null
      cell.onError ->
        expect(cell.error).to.be.instanceOf Error
        callback()
