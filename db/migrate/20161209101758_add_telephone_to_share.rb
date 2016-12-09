class AddTelephoneToShare < ActiveRecord::Migration
  def change
    add_column :shares, :telephone, :string
  end
end
