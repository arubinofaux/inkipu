class CreateMatches < ActiveRecord::Migration[6.0]
  def change
    create_table :matches do |t|
      t.string :bnet_match_id
      t.bigint :player_id
      t.bigint :opponent_id
      t.bigint :winner_id
      t.string :game
      t.boolean :done,            null: false, default: false

      t.timestamps
    end
  end
end
