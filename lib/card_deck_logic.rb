class CardDeckLogic
	include ActiveModel::Model         
  include ActiveModel::Associations  

	attr_accessor :cards, :deck_number

	has_many :cards

	def initialize deck_number
		@deck_number = deck_number
		@logger = Logger.new(STDOUT)
		@cards ||= []
		Card.suits.keys.each do |suit|
			Card.denominations.keys.each do |denomination|
				self.cards << Card.new( {:denomination_cd => Card.denominations[denomination], :suit_cd =>  Card.suits[suit]})
			end
		end
	end

	def remaining_deck_cards
		@cards.select{|card| !card.dealt}
	end

	def get_random_card_from_deck
		card = remaining_deck_cards.sample
		card.mark_as_dealt
		card
	end
end