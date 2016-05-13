BlackJack.Views.Users ||= {}

class BlackJack.Views.Users.PlayerView extends Backbone.View
	template: JST["backbone/templates/users/player"]

	initialize: () ->	
		@card_list_view = new BlackJack.Views.Cards.CardListView
			cards: @model.get('cards')
		@card_list_view.render()

	render: ->
		$('.dev-players').append @template(name: @model.get('name'), score: @model.get('score') )
		$("*[data-user='" + @model.get('name') + "']").html @card_list_view.render().el
		return this