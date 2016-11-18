class ChangeMembersColumnToString < ActiveRecord::Migration
  def change
    remove_column :shares, :members
    add_column :shares, :members, :string
  end
end
