class RemoveWorkgroupFromShares < ActiveRecord::Migration
  def change
    remove_column :shares, :workgroup
  end
end
