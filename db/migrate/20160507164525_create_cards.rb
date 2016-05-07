class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :suit_cd
      t.integer :denomination_cd
      t.integer :card_set_id

      t.timestamps null: false
    end
  end
end
