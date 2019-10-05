class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :bnet_name
      t.integer :user_id, null: true

      t.timestamps
    end
  end
end
