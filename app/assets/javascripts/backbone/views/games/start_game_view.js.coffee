BlackJack.Views.Games ||= {}

class BlackJack.Views.Games.StartGameView extends Backbone.View
  template: JST["backbone/templates/games/start_game"]

  render: ->
    @$el.html(@template())
    return this
