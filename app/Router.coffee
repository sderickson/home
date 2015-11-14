NotFoundView = require('views/NotFoundView')
go = FrimFram.Router.go

class Router extends FrimFram.Router

  #- Routing map
  
  routes:
    '': go('HomeView')
    
    '*name': 'showNotFoundView'
    
  showNotFoundView: ->
    @openView new NotFoundView()

module.exports = Router