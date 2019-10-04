class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :bnet_match_id
      t.integer :player_id
      t.integer :opponent_id
      t.integer :winner

      t.timestamps
    end
  end
end
