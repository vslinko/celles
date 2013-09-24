module.exports = class BaseCell
  value: null

  constructor: ->
    @callbacks = []

  onChange: (callback) ->
    @callbacks.push callback

  subscribe: (callback) ->
    @onChange callback
    callback @value

  triggerChange: ->
    callback @value for callback in @callbacks
