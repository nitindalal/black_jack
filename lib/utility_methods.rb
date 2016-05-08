module UtilityMethods

	def create_new_player(player_name=nil, role_cd=User.roles[:player],logger=Logger.new(STDOUT))
		unless player_name
			logger.info 'Please enter player name'
			player_name = gets.chomp().strip().humanize
		end
		User.new({ :name => player_name, :role_cd => role_cd})
	end

	def fetch_player_response(logger=Logger.new(STDOUT))
		player_response = ''
		while !(player_response == 'H' or player_response == 'S')
			if player_response == ''
				logger.info "What do you want to do? Hit or Stand?. H/S"
			else
				logger.info 'Not a valid reponse. Please only enter H or S'
			end
			player_response = gets.chomp().strip.capitalize
		end
		player_response
	end

	def print_player_details game
		game.dealer.print_details
		game.player.print_details
	end

end