class CreateCardDecksGamesJoinTable < ActiveRecord::Migration
  def change
    create_table :card_decks_games, id: false do |t|
      t.integer :game_id
      t.integer :card_deck_id
    end
 
    add_index :card_decks_games, :game_id
    add_index :card_decks_games, :card_deck_id
  end
end