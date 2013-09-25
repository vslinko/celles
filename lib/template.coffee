BaseCell = require "./base_cell.coffee"


class TemplateCell extends BaseCell
  constructor: (@template) ->
    super()

    @calculate()

    for key, cell of @template
      do (key, cell) =>
        if cell instanceof BaseCell
          cell.onChange =>
            if @value[key] isnt cell.value
              @value[key] = cell.value
              @triggerChange()

  calculate: ->
    @value = {}

    for key, cell of @template
      @value[key] = if cell instanceof BaseCell
        cell.value
      else
        cell


module.exports = (template) ->
  new TemplateCell template

module.exports.TemplateCell = TemplateCell
