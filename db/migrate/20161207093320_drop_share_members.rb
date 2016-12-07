class DropShareMembers < ActiveRecord::Migration
  def change
    remove_column :shares, :members
  end
end

