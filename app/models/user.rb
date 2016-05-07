require 'game'
class User < ActiveRecord::Base
	attr_accessor :role

	has_many :cards

	# TODO - create a can_deal module for this method
	def deal player, number

	end

	def add_card card
		self.cards << card
	end

	def score
		self.cards.inject(0){|score, card| score += card.denomination_cd }
	end


end
