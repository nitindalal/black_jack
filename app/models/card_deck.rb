class CardDeck
	include ActiveModel::Model         
  include ActiveModel::Associations  

	attr_accessor :cards, :deck_number

	has_many :cards

	def initialize deck_number
		@deck_number = deck_number
		@cards ||= []
		Card.suits.keys.each do |suit|
			Card.denominations.keys.each do |denomination|
				self.cards << Card.new( {:denomination_cd => Card.denominations[denomination], :suit_cd =>  Card.suits[suit]})
			end
		end
	end
end