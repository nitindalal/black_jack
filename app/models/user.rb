require 'game'
class User < ActiveRecord::Base
	attr_accessor :role_cd

	has_many :cards

	as_enum :role, dealer: 1, player: 2

	# TODO - create a can_deal module for this method
	def deal player, number

	end

	def add_card card
		self.cards << card
	end

	def score
		self.cards.inject(0){|score, card| score += card.denomination_cd }
	end

	def print_details
		puts self.name + " has score of #{self.score.to_s} from cards- " + self.cards.map{|card| card.denomination_cd.to_s + '-' + card.suit.to_s + '-' + card.card_set.to_s}.join(',')
		puts ''
	end
end
