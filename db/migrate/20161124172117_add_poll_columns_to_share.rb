class AddPollColumnsToShare < ActiveRecord::Migration
  def change
    add_column :shares, :agreed, :boolean, nukl: false
    add_column :shares, :payment, :integer, null: false
    add_column :shares, :land_help_days, :integer
    add_column :shares, :station_help_days, :integer
    add_column :shares, :workgroup, :string
    add_column :shares, :skills, :string
    add_column :shares, :no_help, :boolean, null: false
  end
end
