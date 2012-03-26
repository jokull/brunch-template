# {SlidesView, Slides} = require 'slideshow'
Facebook = require 'facebook'

Application =
  
  views: {}
  collections: {}
  models: {}
  
  constructor: ->
    ($ 'document').ready =>
      @initialize this
      Backbone.history.start()
      
  initialize: (options) ->
    # Init slideshows or whatever
    
    facebook = new Facebook 
      appId: '277988345614501'
      scope: 'email'
    facebook.loadSDK()
    
    setTimeout(->
      ($ ".login").bind "click", (event) ->
        console.log "HEY"
        event.preventDefault()
        facebook.triggerLogin()
    , 300)

# Freeze the object
Object.freeze? Application

module.exports = Application
    
