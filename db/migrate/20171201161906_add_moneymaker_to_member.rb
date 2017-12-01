class AddMoneymakerToMember < ActiveRecord::Migration
  def change
    add_column :members, :moneymaker, :boolean, default: false, null: false   
  end
end
