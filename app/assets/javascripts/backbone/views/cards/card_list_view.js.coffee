BlackJack.Views.Cards ||= {}

class BlackJack.Views.Cards.CardListView extends Backbone.View
	template: JST["backbone/templates/cards/card_list"]

	initialize: (options) ->
		@cards = options.cards
		@card_views = []
		@card_models = []

	render: ->
		@$el.html(@template())
		_.each @cards, ((card) =>
			card_model = new BlackJack.Models.Card(card)
			card_view = new BlackJack.Views.Cards.CardView
				model: card_model
			@$('.dev-user-cards').append card_view.render()
			@card_models.push card_model
			@card_views.push card_view
		)
		return this