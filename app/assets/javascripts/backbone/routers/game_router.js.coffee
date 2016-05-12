class BlackJack.Routers.GamesRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    "start_game": "start_game"
  
  start_game: ->
    @view = new BlackJack.Views.Games.StartGameView()
    $("#games").html(@view.render().el)

