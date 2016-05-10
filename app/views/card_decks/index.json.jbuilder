json.array!(@card_decks) do |card_deck|
  json.extract! card_deck, :id
  json.url card_deck_url(card_deck, format: :json)
end
