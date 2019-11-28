class AddSuperMoneymakerToShares < ActiveRecord::Migration
  def change
    add_column :shares, :super_moneymaker, :boolean, default: false, null: false   
  end
end
