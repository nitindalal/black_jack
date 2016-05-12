class BlackJack.Routers.GamesRouter extends Backbone.Router
	initialize: (options) ->
		@options = options
		console.log 'initialized'

	routes:
		"*games*": "start_game"

	start_game: ->
		console.log 1
		@view = new BlackJack.Views.Games.StartGameView
			game: @options.game
		$("#games").html(@view.render().el)

