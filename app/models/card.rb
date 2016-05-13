class Card < ActiveRecord::Base
	attr_accessor :dealt

	belongs_to :user
	belongs_to :card_deck

	attr_accessible :suit_cd, :denomination_cd, :dealt

	@@suit_symbols = {'spades' => '♠' ,'hearts' =>	'♥', 'diamonds' =>	'♦',	'clubs' => '♠'}

	as_enum :denomination, 'A': 11, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, '10': 10, 'J': 10, 'Q': 10, 'K': 10
	as_enum :suit, diamonds: 1, clubs: 2, hearts: 3, spades: 4

	def mark_as_dealt
		self.dealt = true
		self.save
	end

	def symbol
		@@suit_symbols[self.suit.to_s]
	end

end
