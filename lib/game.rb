class Game

	include ActiveModel::Model         
  include ActiveModel::Associations 

	attr_accessor :dealer, :player

	has_many :card_decks

	# TODO: rename users to players
	# TODO change this later to initialize players first. or better ask for player name when initialized it called
	def initialize(card_decks=6)
		initialize_new_card_decks card_decks
		initialize_players
		@infinity = (1.0/0.0)
	end

	def play
		# TODO: find a better place to do it
		deal_first_cards
		print_player_details
		winner = hit
		print_player_details
		puts winner.name + " has won the game with " + winner.score.to_s + ' points'
	end

	def initialize_players
		@dealer = create_new_player 'System', User.roles[:dealer]
		@player = create_new_player
	end

	def create_new_player(player_name=nil, role_cd=User.roles[:player])
		unless player_name
			puts 'Please enter player name'
			player_name = gets.chomp().strip().humanize
		end
		User.new({ :name => player_name, :role_cd => role_cd})
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
			print_player_details

			puts "What do you want to do? Hit or Stand?. H/S"
			player_response = gets.chomp().strip.capitalize
			if player_response == 'H'
				hit
			elsif player_response == 'S'
				stand
			else
				# TODO handle this exception somehow!!
				puts "please enter H or S only"
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
			print_player_details
			stand
		when 17..@infinity
			# TODO ask what happens when they are equal
			return (@player.score >= @dealer.score ? @player : @dealer)
		end
	end

	def remaining_cards
		@card_decks.inject([]){|cards,deck| cards |= deck.cards.select{|card| !card.dealt}}
	end

	# TODO: somehow the deal method should be on the dealer, user
	def get_random_card
		card = remaining_cards.sample
		card.dealt = true
		card
	end

	def print_player_details
		@dealer.print_details
		@player.print_details
	end

	def deal player
		puts "Dealt a card to " + player.name
		puts 'cards remaining now - ' + remaining_cards.count.to_s
		puts ''
		player.add_card get_random_card
	end
end