class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new
    
  end

  def new_game
    @dealer = User.create( { :name => 'System'})
    @player = User.create( { :name => 'Player1'})
    @game = Game.new({:player_id => @player.id, :dealer_id => @dealer.id})
    @game.play
    @game.save
    @game_json = @game.as_json(:methods => :winner ,:include => { :card_decks => {
                            :include => { :cards => { :methods => [:suit, :denomination, :suit_cd, :denomination_cd, :symbol], :only => :body } },
                             :only => :title }, :dealer => { :include => {:cards => { :methods => [:suit, :denomination, :suit_cd, :denomination_cd, :symbol], :only => :body } } },
                             :player => { :include => {:cards => { :methods => [:suit, :denomination, :suit_cd, :denomination_cd, :symbol], :only => :body } } }  })
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def player_hit
    debugger
    game = Game.find params[:id]
    game.winner = game.hit
    game.save
    game_json = game.as_json(:methods => :winner ,:include => { :card_decks => {
                            :include => { :cards => { :methods => [:suit, :denomination, :suit_cd, :denomination_cd, :symbol], :only => :body } },
                             :only => :title }, :dealer => { :include => {:cards => { :methods => [:suit, :denomination, :suit_cd, :denomination_cd, :symbol], :only => :body } } },
                             :player => { :include => {:cards => { :methods => [:suit, :denomination, :suit_cd, :denomination_cd, :symbol], :only => :body } } }  })
    format.json { render json: @game.to_json , status: 200 }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:dealer_id, :player_id)
    end
end
