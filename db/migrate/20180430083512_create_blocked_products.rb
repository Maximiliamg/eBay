class CreateBlockedProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :blocked_products do |t|

      t.timestamps
    end
  end
end
