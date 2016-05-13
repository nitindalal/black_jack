BlackJack.Views.Cards ||= {}

class BlackJack.Views.Cards.CardView extends Backbone.View
	template: JST["backbone/templates/cards/card"]

	render: ->
		@template(symbol: @model.get('symbol'), denomination: @model.get('denomination'))