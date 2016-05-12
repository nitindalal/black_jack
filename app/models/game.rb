class Game < ActiveRecord::Base

	include UtilityMethods

	belongs_to :dealer, :class_name => 'User'
	belongs_to :player, :class_name => 'User'

	has_and_belongs_to_many :card_decks

	attr_accessor :dealer, :player, :card_decks

	after_initialize :initialize_components

	def initialize_components(card_decks=6)
		initialize_new_card_decks card_decks
		initialize_players
		@infinity = (1.0/0.0)
		@logger = Logger.new(STDOUT)
		@logger.level = 1
	end

	# call this method to start the game after initializing
	def play
		deal_first_cards
		print_player_details self

		# hit the player and let the fun begin
		#winner = hit

		# print player score when the game ends
		# print_player_details self
		# @logger.info winner.name + " has won the game with " + winner.score.to_s + ' points'
	end

	# initialize system and player
	def initialize_players
		@dealer = create_new_player 'System', User.roles[:dealer]
		@player = create_new_player 'Player1'
	end
	
	# initialize the card decks for game. 
	def initialize_new_card_decks(decks)
		@card_decks ||= []
		for deck in 1..decks
			@card_decks << CardDeck.new
		end
	end

	# deal the first two cards to dealer and player each
	def deal_first_cards
		deal @dealer
		deal @player
	end

	# hit the player and follow the game logic
	# if player score is 21 -  player wins
	# if player score is greater than 21 - dealer wins
	# if player score is less than 20 - ask the player what he wants to do: Hit or Stand

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

	# when the player chooses - stand
	# deal card to dealer and check the score
	# if dealer score is 21 - dealer wins
	# if dealer score is greater than 21 - player wins
	# if dealer score is less than 17 - deal another card to dealer and check the score again for the cases
	# if dealer score is between 17 and 20, whoever has greater score, wins the game.
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
		when 17..20
			# TODO ask what happens when they are equal. For now player wins in case of equal
			return (@player.score >= @dealer.score ? @player : @dealer)
		end
	end

	# find remaining cards
	def remaining_cards
		@card_decks.inject([]){|cards,deck| cards |= deck.remaining_deck_cards}
	end

	def get_random_card
		card = @card_decks.select{|deck| deck.remaining_deck_cards.count > 0 }.sample.get_random_card_from_deck
	end

	def deal player
		player.add_card get_random_card
		@logger.info "Dealt a card to " + player.name
		@logger.debug 'remaining cards are ' + remaining_cards.count.to_s
		@logger.info ''
	end

end
