class BlackJack.Models.Game extends Backbone.Model
  paramRoot: 'game'

  defaults:
    game_id: null

class BlackJack.Collections.GamesCollection extends Backbone.Collection
  model: BlackJack.Models.Game
  url: '/games'
