class AddMoneymakerToShares < ActiveRecord::Migration
  def change
    add_column :shares, :moneymaker, :boolean, default: false, null: false   
  end
end
