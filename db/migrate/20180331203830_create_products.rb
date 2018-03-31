class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :category
      t.string :shipping_description
      t.integer :origin_id
      t.integer :user_id
      t.integer :stock
      t.float :price
      t.boolean :is_auction, default: 0
      t.boolean :is_used, default: 0

      t.timestamps
    end
  end
end
