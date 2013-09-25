BaseCell = require "./base_cell.coffee"


class PromiseCell extends BaseCell
  constructor: (promise) ->
    super()

    promise.then (value) =>
      @value = value
      @triggerChange()
    , (error) =>
      @error = error
      @triggerError()


module.exports = (promise) ->
  new PromiseCell promise

module.exports.PromiseCell = PromiseCell
