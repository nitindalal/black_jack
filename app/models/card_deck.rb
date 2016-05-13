class CardDeck < ActiveRecord::Base

	has_and_belongs_to_many :games

	attr_accessor :cards

	has_many :cards
	accepts_nested_attributes_for :cards

	after_initialize :initialize_cards

	def initialize_cards
		@cards ||= []
		Card.suits.keys.each do |suit|
	    Card.denominations.keys.each do |denomination|
	      @cards << Card.create( {:denomination_cd => Card.denominations[denomination], :suit_cd =>  Card.suits[suit]})
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
