class Game
	include UtilityMethods

	include ActiveModel::Model         
  include ActiveModel::Associations 

	attr_accessor :dealer, :player

	has_many :card_decks

	def initialize(card_decks=6)
		initialize_new_card_decks card_decks
		initialize_players
		@infinity = (1.0/0.0)
	end

	def play
		deal_first_cards
		print_player_details self
		winner = hit
		print_player_details self
		puts winner.name + " has won the game with " + winner.score.to_s + ' points'
	end

	def initialize_players
		@dealer = create_new_player 'System', User.roles[:dealer]
		@player = create_new_player
	end
	
	def initialize_new_card_decks(decks)
		@card_decks ||= []
		for deck in 1..decks
			@card_decks << CardDeck.new({:deck_number => deck})
		end
	end

	def deal_first_cards
		deal @dealer
		deal @player
	end

	def hit
		deal @player
		case @player.score
		when  21
			return @player
		when 21..@infinity
			return @dealer
		when 1..20
			print_player_details self
			player_response = fetch_player_response

			if player_response == 'H'
				hit
			elsif player_response == 'S'
				stand
			end
		end
	end

	def stand
		deal @dealer
		case @dealer.score
		when  21
			return @dealer
		when 21..@infinity
			return @player
		when 1..16
			print_player_details self
			stand
		when 17..@infinity
			# TODO ask what happens when they are equal. For now player wins in case of equal
			return (@player.score >= @dealer.score ? @player : @dealer)
		end
	end

	def remaining_cards
		@card_decks.inject([]){|cards,deck| cards |= deck.remaining_deck_cards}
	end

	def get_random_card
		card = remaining_cards.sample
		card.dealt = true
		card
	end

	def deal player
		puts "Dealt a card to " + player.name
		puts ''
		player.add_card get_random_card
	end
end