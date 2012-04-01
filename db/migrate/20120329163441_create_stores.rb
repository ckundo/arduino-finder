class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.integer :zip
      t.string :url
      t.string :phone

      t.timestamps
    end
  end
end
