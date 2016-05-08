require 'game'
class Card < ActiveRecord::Base
	attr_accessor :card_set, :denomination_cd, :suit_cd, :dealt

	belongs_to :user
	belongs_to :card_deck

	as_enum :denomination, ace: 11, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10, jack: 10, queen: 10, king: 10
	as_enum :suit, diamond: 1, clubs: 2, hearts: 3, spade: 4

	def mark_as_dealt
		self.dealt = true
	end

end
