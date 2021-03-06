class User < ActiveRecord::Base
	attr_accessor :role_cd

	has_many :cards

	has_many :games_as_dealer, foreign_key: "dealer_id", class_name: "Game"
	has_many :games_as_player, foreign_key: "player_id", class_name: "Game"

	as_enum :role, dealer: 1, player: 2

	accepts_nested_attributes_for :cards

	def add_card card
		self.cards << card
	end

	def score
		self.cards.inject(0){|score, card| score += card.denomination_cd }
	end

	def print_details
		@logger ||= Logger.new(STDOUT)
		@logger.info self.name + " has score of #{self.score.to_s} from cards- " + self.cards.map{|card| card.denomination_cd.to_s + '-' + card.suit.to_s}.join(',')
		@logger.info ''
	end
end
