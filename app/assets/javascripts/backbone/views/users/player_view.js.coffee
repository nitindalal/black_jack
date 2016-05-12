BlackJack.Views.Users ||= {}

class BlackJack.Views.Users.PlayerView extends Backbone.View
	template: JST["backbone/templates/users/player"]

	initialize: () ->	
		console.log 'player initialized'

	render: ->
		@$el.html(@template(name: @model.get('name')))
		return this