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
      throw cell.error if cell.error
      valueRoot[key] = cell.value
      cellCallback cell if cellCallback

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

    if @template instanceof BaseCell
      throw new Error "Unable to create template cell from other cell"

    if not Array.isArray(@template) and @template not instanceof Object
      throw new Error "Unable to create template cell from scalar value"

    @calculate (cell) =>
      cell.onChange => @calculate()
      cell.onError => @calculate()

  calculate: (cellCallback) ->
    @error = null

    @value = if Array.isArray @template
      []
    else if @template instanceof Object
      {}

    try
      recursivelyCalculate @value, @template, cellCallback
      @triggerChange()
    catch error
      @value = null
      @error = error
      @triggerError()


module.exports = (template) ->
  new TemplateCell template

module.exports.TemplateCell = TemplateCell
