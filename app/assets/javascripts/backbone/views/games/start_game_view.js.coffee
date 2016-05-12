BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
	template: JST["backbone/templates/games/start_game"]

	initialize: () ->	
		card_view = new BlackJack.Views.Cards.NewCardView
		@$el.html (card_view.render().el)

	render: ->
		console.log 'rendered view'
		#@$el.html(@template())
		return this
