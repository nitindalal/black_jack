BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
	template: JST["backbone/templates/games/start_game"]

	initialize: (options) ->
		game = options.game	
		dealer = new BlackJack.Models.User(game.dealer)
		dealer_view = new BlackJack.Views.Users.PlayerView
			model: dealer
		player = new BlackJack.Models.User(game.player)
		player_view = new BlackJack.Views.Users.PlayerView
			model: player
		dealer_view.render()
		player_view.render()

	render: ->
		#@$el.html(@template())
		return this
