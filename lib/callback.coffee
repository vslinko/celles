BaseCell = require "./base_cell.coffee"


class CallbackCell extends BaseCell
  constructor: (callback) ->
    super()

    callback (value) =>
      if value isnt @value
        @value = value
        @triggerChange()


module.exports = (callback) ->
  new CallbackCell callback

module.exports.CallbackCell = CallbackCell
