class AddPasswdResetTimestampToShares < ActiveRecord::Migration
  def change
    add_column :shares, :password_reset_timestamp, :datetime
  end
end
