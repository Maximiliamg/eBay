class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.integer :purchase_id
      t.integer :product_id
      t.integer :quantity, default: 1
      t.integer :buyer_score, default: 0
      t.integer :seller_score, default: 0

      t.timestamps
    end
  end
end
