{SlidesView, Slides} = require 'slideshow'

Application =
  
  views: {}
  collections: {}
  models: {}
  
  initialize: ->
    app = @
    ($ ".slideshow").each (i) ->
      collection = new Slides
      view = new SlidesView 
        collection: collection
        el: @
      view.addDOMSlides()
      collection.select collection.first()
      

# Freeze the object
Object.freeze? Application

module.exports = Application
    
