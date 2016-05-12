class BlackJack.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    name: null
    score: null

class BlackJack.Collections.UsersCollection extends Backbone.Collection
  model: BlackJack.Models.User
  url: '/users'
