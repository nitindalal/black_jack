BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
	template: JST["backbone/templates/games/start_game"]

	initialize: (options) ->
		game = options.game	
		dealer = new BlackJack.Models.User(game.dealer)
		dealer_view = new BlackJack.Views.Users.PlayerView
			model: dealer
			el: '.dev-dealer-cards'
		player = new BlackJack.Models.User(game.player)
		player_view = new BlackJack.Views.Users.PlayerView
			model: player
			el: '.dev-player-cards'
		@$('.dev-dealer-cards').html dealer_view.render().el
		@$('.dev-player-cards').html player_view.render().el

	render: ->
		console.log 'rendered view'
		#@$el.html(@template())
		return this
