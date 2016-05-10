json.array!(@games) do |game|
  json.extract! game, :id, :dealer_id, :player_id
  json.url game_url(game, format: :json)
end
