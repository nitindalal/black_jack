json.array!(@cards) do |card|
  json.extract! card, :id, :suit_cd, :denomination_cd, :card_set_id
  json.url card_url(card, format: :json)
end
