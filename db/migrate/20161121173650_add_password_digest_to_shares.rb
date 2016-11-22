class AddPasswordDigestToShares < ActiveRecord::Migration
  def change
    add_column :shares, :email, :string
    add_column :shares, :password_digest, :string
  end
end
