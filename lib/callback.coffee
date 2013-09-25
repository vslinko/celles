BaseCell = require "./base_cell.coffee"


class CallbackCell extends BaseCell
  constructor: (callback) ->
    super()

    try
      callback (value) =>
        changed = false

        if @error isnt null
          changed = true
          @error = null

        if value isnt @value
          @value = value
          changed = true

        if changed
          @triggerChange()

    catch error
      @error = error


module.exports = (callback) ->
  new CallbackCell callback

module.exports.CallbackCell = CallbackCell
