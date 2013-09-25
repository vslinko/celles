BaseCell = require "./base_cell.coffee"


class FormulaCell extends BaseCell
  constructor: (@cells, @formula) ->
    super()

    @calculate()

    @cells.forEach (cell) =>
      if cell instanceof BaseCell
        cell.onChange => @calculate()

  calculate: ->
    args = @cells.map (cell) ->
      if cell instanceof BaseCell
        cell.value
      else
        cell

    changed = false

    if @error
      @error = null
      changed = true

    try
      previousValue = @value

      @value = @formula.apply @, args

      if previousValue isnt @value
        changed = true

    catch error
      @value = null
      @error = error
      @triggerError()
      return

    if changed
      @triggerChange()


module.exports = (cells, formula) ->
  new FormulaCell cells, formula

module.exports.FormulaCell = FormulaCell
