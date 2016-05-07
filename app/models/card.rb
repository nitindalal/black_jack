require 'game'
class Card < ActiveRecord::Base
	attr_accessor :card_set_id, :denomination_cd, :suit_cd, :dealt

	belongs_to :user

	as_enum :denomination, ace: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9, ten: 10, jack: 11, queen: 12, king: 13
	as_enum :suit, diamond: 1, clubs: 2, hearts: 3, spade: 4
end
