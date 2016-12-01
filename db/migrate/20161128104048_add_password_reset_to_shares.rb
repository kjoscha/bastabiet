class AddPasswordResetToShares < ActiveRecord::Migration
  def change
    add_column :shares, :password_reset_digest, :string
  end
end
