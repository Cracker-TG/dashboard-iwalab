class Dashing.GoogleDocs2 extends Dashing.Widget
  @accessor 'style', ->
  	{
  	 backgroundImage: 'url(' + @get('doc2') + ')'
  	}
  ready: ->
    # This is fired when the widget is done being rendered

  onData: (data) ->
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
