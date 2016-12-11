class AddTotalSharesToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :total_shares, :integer, default: 145, null: false
  end
end
