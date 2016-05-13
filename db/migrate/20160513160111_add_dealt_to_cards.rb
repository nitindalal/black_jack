class AddDealtToCards < ActiveRecord::Migration
  def change
    add_column :cards, :dealt, :boolean
  end
end
