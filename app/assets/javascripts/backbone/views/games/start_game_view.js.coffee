BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
	template: JST["backbone/templates/games/start_game"]

	el: '.game-outer'

	events:
		'click .dev-hit-button'   : 'fetch_game'
		'click .dev-stand-button' : 'fetch_game'

	initialize: (options) ->
		@game = options.game

	fetch_game:(e) =>
		method = $(e.currentTarget).data('method')
		$.ajax
			url: 'games/player_method'
			type: 'POST'
			dataType: 'JSON'
			data:
				id: @game.id
				method: method
			error: (jqXHR, textStatus, errorThrown) ->
			success: (data, textStatus, jqXHR) =>
				_this.game = data
				_this.render()

	render: ->
		#@$el.html(@template())
		$('.dev-players').html ''
		dealer = new BlackJack.Models.User(@game.dealer)
		dealer_view = new BlackJack.Views.Users.PlayerView
			model: dealer
		player = new BlackJack.Models.User(@game.player)
		player_view = new BlackJack.Views.Users.PlayerView
			model: player
		dealer_view.render()
		player_view.render()
		alert @game.winner.name + " has won the game!!" if @game.winner != null
		return this
