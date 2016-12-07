class DropNullConstraintFromPayment < ActiveRecord::Migration
  def change
    change_column :shares, :payment, :integer, null: true
  end
end
