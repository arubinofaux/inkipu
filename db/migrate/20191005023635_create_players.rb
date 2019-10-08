class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :name
      t.string :bnet_name, index: {unique: true}
      t.bigint :user_id, null: true

      t.timestamps
    end
  end
end
