class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      #t.integer :user_id
      t.integer :product_id
      t.integer :quantity, default: 1
      t.integer :buyer_score
      t.integer :seller_score
      t.references :seller, index: true, foreign_key: true
      t.references :buyer, index: true, foreign_key: true
      t.boolean :is_shipped, default: false
      t.boolean :is_delivered, default: false

      t.timestamps
    end
  end
end
