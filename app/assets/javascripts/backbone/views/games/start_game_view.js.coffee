BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
	template: JST["backbone/templates/games/start_game"]

	el: '.game-outer'

	events:
		'click .dev-hit-button'   : 'hit'
		'click .dev-stand-button' : 'stand'

	initialize: (options) ->
		@game = options.game	
		dealer = new BlackJack.Models.User(@game.dealer)
		dealer_view = new BlackJack.Views.Users.PlayerView
			model: dealer
		player = new BlackJack.Models.User(@game.player)
		player_view = new BlackJack.Views.Users.PlayerView
			model: player
		dealer_view.render()
		player_view.render()

	hit:() ->
		$.ajax
			url: 'hit'
			type: 'POST'
			dataType: 'JSON'
			data:
				id: @game.id
		error: (jqXHR, textStatus, errorThrown) ->
			debugger
			$('body').append "AJAX Error: #{textStatus}"
		success: (data, textStatus, jqXHR) ->
			debugger
			$('body').append "Successful AJAX call: #{data}"

	stand:() ->
		console.log 'stand' 

	render: ->
		#@$el.html(@template())
		return this
