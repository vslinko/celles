BaseCell = require "./base_cell.coffee"


class Cell extends BaseCell
  constructor: (@value) ->
    super()

  set: (value) ->
    changed = false

    if @error isnt null
      changed = true
      @error = null

    if value isnt @value
      @value = value
      changed = true

    if changed
      @triggerChange()

  throw: (@error) ->
    @value = null
    @triggerError()


module.exports = (value) ->
  new Cell value

module.exports.Cell = Cell
