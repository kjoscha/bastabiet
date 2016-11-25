class AddActivationToShares < ActiveRecord::Migration
  def change
    add_column :shares, :activation_digest, :string
    add_column :shares, :activated, :boolean, default: false
  end
end
