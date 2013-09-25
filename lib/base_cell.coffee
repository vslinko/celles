module.exports = class BaseCell
  value: null
  error: null

  constructor: ->
    @callbacks = change: [], error: []

  onChange: (callback) ->
    @callbacks.change.push callback

  onError: (callback) ->
    @callbacks.error.push callback

  subscribe: (callback) ->
    @onChange callback
    @onError callback
    callback @value, @error

  triggerChange: ->
    callback @value, @error for callback in @callbacks.change

  triggerError: ->
    callback @value, @error for callback in @callbacks.error
