View = require 'core/View'

class RootView extends View

  onInsert: ->
    super(arguments...)
    title = _.result(@, 'title') or _.result(RootView, 'globalTitle') or @constructor.name
    $('title').text(title)

  title: _.noop

  @globalTitle: _.noop

  onLeaveMessage: _.noop

module.exports = RootView