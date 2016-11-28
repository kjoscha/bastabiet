class AddFeedbackToShares < ActiveRecord::Migration
  def change
    add_column :shares, :feedback, :text
    remove_column :shares, :station_help_days
  end
end
