BaseCell = require "./base_cell.coffee"


recursivelyCalculate = (valueRoot, templateRoot, callback) ->
  for key, cell of templateRoot
    if cell instanceof BaseCell
      valueRoot[key] = cell.value
      callback valueRoot, key, cell if callback

    else if cell instanceof Object
      valueRoot[key] = {}
      recursivelyCalculate valueRoot[key], cell, callback

    else
      valueRoot[key] = cell



class TemplateCell extends BaseCell
  constructor: (@template) ->
    super()

    @value = {}

    recursivelyCalculate @value, @template, (valueRoot, key, cell) =>
      cell.onChange =>
        if valueRoot[key] isnt cell.value
          valueRoot[key] = cell.value
          @triggerChange()

  calculate: ->
    @value = {}
    recursivelyCalculate @value, @template


module.exports = (template) ->
  new TemplateCell template

module.exports.TemplateCell = TemplateCell
