# These Backbone classes add CSS3 animation



class ShortcutView extends Backbone.View
  
  events:
    click: "click"
  initialize: (options) ->
    
  click: (event) =>
    event.preventDefault()
    @model.select()

class ShortcutsView extends Backbone.View
  
  initialize: (options) ->
    @collection.bind "select", @select
    @reset()
  
  add: (model) =>
    view = new ShortcutView el: @el, model: model
    ($ @el).append view.el
    ($ view.el).attr "href", "#"
      
  reset: =>
    ($ @el).html ""
    @collection.each @add
      
  select: (slide) =>
    ($ "a", @el).removeClass "selected"
    ($ "a.index-" + slide.get("index"), @el).addClass "selected"
    

class exports.SlideView extends Backbone.View
  
  tagName: "a"
  initialize: (options) ->
    ($ @el).css "left", @left()
  
  left: =>
    ($ @el).width() * (@model.get "index")
  

class exports.SlidesView extends Backbone.View
  
  heightSelector: ".carousel, .carousel nav a, .carousel li"
  widthSelector: ".carousel li"
  
  events:
    "click .next": "next"
    "click .previous": "previous"
  
  initialize: (options) ->
    # This breaks responsive layout if window is resized
    # Maybe we can fix by re-initializing?
    @setHeight()
    @shortcuts = new ShortcutsView
      collection: @collection
      el: ($ "nav.slides", @el).get(0)
  
  setHeight: =>
    width = ($ @el).css "width"
    height = ($ "li", @el).first().css "height"
    ($ @heightSelector, @el).css "height", height
    ($ @widthSelector, @el).css "width", width
    ($ @el).addClass "ready"
    @collection.bind "select", @select
  
  addDOMSlides: =>
    ($ "ol.slides li", @el).each (i, el) =>
      index = ($ el).data "index" or i
      model = new exports.Slide index: index
      model.view = new exports.SlideView el: el, model: model
      @collection.add model
  
  next: (e) =>
    e.preventDefault()
    @collection.selected.next().select()
    
  previous: (e) =>
    e.preventDefault()
    @collection.selected.previous().select()
  
  select: (slide) =>
    index = slide.get "index"
    ($ "nav a", @el).removeClass "disabled"
    if @collection.last() == slide
      ($ "nav a.next", @el).addClass "disabled"
    if @collection.first() == slide
      ($ "nav a.previous", @el).addClass "disabled"
    ($ "ol.slides", @el).css "margin-left", slide.view.left() * -1
  
  
class exports.Slide extends Backbone.Model
  
  select: =>
    @collection.select @
  
  shift: (direction) =>
    index = Number(@get "index") + direction
    slide = @collection.find (slide) =>
      (slide.get "index") == String index
    slide
  
  next:     => @shift  1
  previous: => @shift -1


class exports.Slides extends Backbone.Collection
  model: exports.Slide
  
  select: (slide) =>
    @selected = slide
    @trigger "select", @selected
    


