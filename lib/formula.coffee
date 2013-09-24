BaseCell = require "./base_cell"


class FormulaCell extends BaseCell
  constructor: (@cells, @formula) ->
    super()

    @calculate()

    @cells.forEach (cell) =>
      if cell instanceof BaseCell
        cell.onChange =>
          previousValue = @value
          @calculate()
          if previousValue isnt @value
            @triggerChange()

  calculate: ->
    args = @cells.map (cell) ->
      if cell instanceof BaseCell
        cell.value
      else
        cell

    @value = @formula.apply value: @value, args


module.exports = (cells, formula) ->
  new FormulaCell cells, formula

module.exports.FormulaCell = FormulaCell
