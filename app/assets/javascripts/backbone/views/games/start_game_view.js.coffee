BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
	template: JST["backbone/templates/games/start_game"]

	render: ->
		console.log 'rendered view'
		@$el.html(@template())
		return this
