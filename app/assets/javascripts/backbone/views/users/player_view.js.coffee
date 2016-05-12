BlackJack.Views.Users ||= {}

class BlackJack.Views.Users.PlayerView extends Backbone.View
	template: JST["backbone/templates/users/player"]

	el:'.dev-player-info'

	initialize: () ->	
		@card_list_view = new BlackJack.Views.Cards.CardListView
			cards: @model.get('cards')
		@card_list_view.render()

	render: ->
		$('.dev-players').append (@template(name: @model.get('name')))
		$('.dev-player-cards').html @card_list_view.render().el
		return this