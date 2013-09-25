BaseCell = require "./base_cell.coffee"


iterator = (object, callback) ->
  if Array.isArray object
    object.forEach callback
  else if object instanceof Object
    for key, value of object
      if object.hasOwnProperty key
        callback value, key
  else
    throw new Error "Unable to iterate scalar value"


recursivelyCalculate = (valueRoot, templateRoot, cellCallback) ->
  iterator templateRoot, (cell, key) ->
    if cell instanceof BaseCell
      valueRoot[key] = cell.value
      cellCallback valueRoot, key, cell if cellCallback

    else if Array.isArray cell
      valueRoot[key] = []
      recursivelyCalculate valueRoot[key], cell, cellCallback

    else if cell instanceof Object
      valueRoot[key] = {}
      recursivelyCalculate valueRoot[key], cell, cellCallback

    else
      valueRoot[key] = cell



class TemplateCell extends BaseCell
  constructor: (@template) ->
    super()

    @calculate (valueRoot, key, cell) =>
      cell.onChange =>
        if valueRoot[key] isnt cell.value
          valueRoot[key] = cell.value
          @triggerChange()

  calculate: (cellCallback) ->
    if @template instanceof BaseCell
      throw new Error "Unable to create template cell from other cell"
    else if Array.isArray @template
      @value = []
    else if @template instanceof Object
      @value = {}
    else
      throw new Error "Unable to create template cell from scalar value"

    recursivelyCalculate @value, @template, cellCallback


module.exports = (template) ->
  new TemplateCell template

module.exports.TemplateCell = TemplateCell
