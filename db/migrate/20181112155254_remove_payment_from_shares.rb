class RemovePaymentFromShares < ActiveRecord::Migration
  def change
    remove_column :shares, :payment
  end
end
