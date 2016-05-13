class BlackJack.Routers.GamesRouter extends Backbone.Router
	initialize: (options) ->
		@options = options
		console.log 'initialized'

	routes:
		"*game*": "start_game"

	start_game: ->
		console.log 1
		@view = new BlackJack.Views.Games.StartGameView
			game: @options.game
		@view.render()
		#$("#games").html(@view.render().el)

