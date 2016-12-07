class AddActivationTimestampToShares < ActiveRecord::Migration
  def change
    add_column :shares, :activation_timestamp, :datetime
  end
end
