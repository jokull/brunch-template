# {SlidesView, Slides} = require 'slideshow'
Facebook = require 'facebook'

class Application
  
  views: {}
  collections: {}
  models: {}
  routers: {}
  
  ready: ->
    # Init slideshows or whatever
    
    facebook = new Facebook 
      appId: '277988345614501'
      scope: 'email'
    facebook.loadSDK()
    
    ($ ".login").bind "click", (event) ->
      event.preventDefault()
      facebook.triggerLogin "loginbutton"
    
    facebook.getLoginStatus()
      
  initialize: (options) ->
    $ =>
      @ready this
      Backbone.history.start() if Object.keys(@routers).length

# Freeze the object
Object.freeze? Application

module.exports = new Application
    
