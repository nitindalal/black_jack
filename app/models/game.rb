class Game < ActiveRecord::Base

	belongs_to :dealer, :class_name => 'User'
	belongs_to :player, :class_name => 'User'

	has_and_belongs_to_many :card_decks

	
end
