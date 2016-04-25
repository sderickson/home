window.jQuery = $ = require 'jquery'
Backbone = require 'backbone'
_ = require 'underscore'
Bootstrap = require 'bootstrap'

Router = require 'Router'
BaseClass = require 'core/BaseClass'

class Application extends BaseClass
  router: new Router()

  constructor: (options={}) ->
    options = _.defaults options, {
      watchForErrors: true
      preventBackspace: true
    }
    @watchForErrors() if options.watchForErrors
    $(document).bind('keydown', @preventBackspace) if options.preventBackspace
  
  start: ->
    Backbone.history.start({ pushState: true })

  watchForErrors: ->
    window.addEventListener "error", (e) ->
      return if $('body').find('.runtime-error-alert').length
      alert = $(runtimeErrorTemplate({errorMessage: e.error.message}))
      $('body').append(alert)
      alert.addClass('in')
      alert.alert()

  preventBackspace: (e) ->
    if e.keyCode is 8 and not @elementAcceptsKeystrokes(e.srcElement or e.target)
      e.preventDefault()

  # http://stackoverflow.com/questions/1495219/how-can-i-prevent-the-backspace-key-from-navigating-back
  elementAcceptsKeystrokes: (el) ->
    el ?= document.activeElement
    tag = el.tagName.toLowerCase()
    type = el.type?.toLowerCase()
    textInputTypes = ['text', 'password', 'file', 'number', 'search', 'url', 'tel', 'email', 'date', 'month', 'week', 'time', 'datetimelocal']
    # not radio, checkbox, range, or color
    return (tag is 'textarea' or (tag is 'input' and type in textInputTypes) or el.contentEditable in ['', 'true']) and not (el.readOnly or el.disabled)

  isProduction: -> window.location.href.indexOf('localhost') is -1

  wrapBackboneRequestCallbacks: (options) ->
    options ?= {}
    originalOptions = _.clone(options)
    options.success = (model) ->
      model.state = 'standby'
      originalOptions.success?(arguments...)
    options.error = (model) ->
      model.state = 'standby'
      originalOptions.error?(arguments...)
    options.complete = (model) ->
      model.state = 'standby'
      originalOptions.complete?(arguments...)
    return options

  #- Error handling
  onNetworkError = ->
    jqxhr = _.find arguments, (arg) -> arg.promise? and arg.getResponseHeader? # duck typing
  
    r = jqxhr?.responseJSON
    if jqxhr?.status is 0
      s = 'Network failure'
    else if arguments[2]?.textStatus is 'parsererror'
      s = 'Backbone parser error'
    else
      s = r?.message or r?.error or 'Unknown error'
  
    if r
      console.error 'Response JSON:', JSON.stringify(r, null, '\t')
    else
      console.error 'Error arguments:', arguments
  
    alert = $(runtimeErrorTemplate({errorMessage: s}))
    $('body').append(alert)
    alert.addClass('in')
    alert.alert()


runtimeErrorTemplate = _.template("""
  <div class="runtime-error-alert alert alert-danger fade">
    <button class="close" type="button" data-dismiss="alert">
      <span aria-hidden="true">&times;</span>
    </button>
    <span><%= errorMessage %></span>
  </div>
""")



module.exports = Application