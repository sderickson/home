View = require 'core/View'
_ = require 'underscore'

class RootView extends View

  onInsert: ->
    super(arguments...)
    title = _.result(@, 'title') or _.result(RootView, 'globalTitle') or @constructor.name
    $('title').text(title)

  title: _.noop

  @globalTitle: 'Scott Erickson'

  onLeaveMessage: _.noop

module.exports = RootView