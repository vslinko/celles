BaseCell = require "./base_cell"


class Cell extends BaseCell
  constructor: (@value) ->
    super()

  set: (value) ->
    if value isnt @value
      @value = value
      @triggerChange()


module.exports = (value) ->
  new Cell value

module.exports.Cell = Cell
