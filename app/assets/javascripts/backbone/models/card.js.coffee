class BlackJack.Models.Card extends Backbone.Model
  paramRoot: 'card'

  defaults:
    suit: null
    denomination: null
    symbol: null

class BlackJack.Collections.CardsCollection extends Backbone.Collection
  model: BlackJack.Models.Card
  url: '/cards'
