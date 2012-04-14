class ChangeZipToString < ActiveRecord::Migration
  def up
    change_column :stores, :zip, :string
  end

  def down
    change_column :stores, :zip, :integer
  end
end
