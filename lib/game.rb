class Game
	attr_accessor :cards, :dealer, :player 

	#TODO change this later to initialize players first. or better ask for player name when initialized it called
	def initialize(card_sets=6)

		# TODO add gem to allow multiple attributes
		@dealer = User.new
		@dealer.role_cd = 1
		@dealer.name = 'System'

		@player = User.new
		puts 'please enter player name'
		player_name = gets.chomp().strip().humanize
		@player.name = player_name

		initialize_new_card_sets card_sets

		# TODO: find a better place to do it
		deal_first_cards
		print_player_details

		winner = hit
		print_player_details
		puts winner.name + " has won the game with " + winner.score.to_s + ' points'

		puts "do you want to play again? Y/N"
		player_response = gets.chomp().strip().capitalize

	end
	
	def initialize_new_card_sets(number)
		@cards ||= []
		for set in 1..number
			Card.suits.keys.each do |suit|
				Card.denominations.keys.each do |denomination|
					card = Card.new
					card.denomination_cd = Card.denominations[denomination]
					card.suit_cd = Card.suits[suit]
					card.card_set_id = set
					@cards << card
				end
			end
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
		when 21..infinity
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
		when 21..infinity
			return @player
		when 1..16
			print_player_details
			stand
		when 17..infinity
			# TODO ask what happens when they are equal
			return (@player.score >= @dealer.score ? @player : @dealer)
		end
	end

	def remaining_cards
		@cards.select{|card| !card.dealt}
	end

	# TODO: somehow the deal method should be on the dealer, user
	def get_random_card
		card = remaining_cards.sample
		card.dealt = true
		card
	end

	def infinity
		1.0/0.0
	end

	def deal player
		player.add_card get_random_card
		puts 'remaining_cards - ' + remaining_cards.count.to_s
	end

	def print_player_details
		puts @player.name + " has score of #{@player.score.to_s} from cards- " + @player.cards.map{|card| card.denomination_cd.to_s + '-' + card.suit.to_s + '-' + card.card_set_id.to_s}.join(',')
		puts @dealer.name + " has score of #{@dealer.score.to_s} from cards- " + @dealer.cards.map{|card| card.denomination_cd.to_s + '-' + card.suit.to_s + '-' + card.card_set_id.to_s}.join(',')
	end
end