class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.integer :product_id
      t.integer :store_id
      t.string :sku

      t.timestamps
    end
  end
end
