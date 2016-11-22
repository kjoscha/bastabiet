class AddOffersToShares < ActiveRecord::Migration
  def change
    add_column :shares, :offer_minimum, :float
    add_column :shares, :offer_medium, :float
    add_column :shares, :offer_maximum, :float
  end
end
