BlackJack.Views.Cards ||= {}

class BlackJack.Views.Cards.NewCardView extends Backbone.View
  template: JST["backbone/templates/cards/card"]

  render: ->
    @$el.html(@template())
    return this