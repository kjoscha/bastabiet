class CreateWorkgroupShares < ActiveRecord::Migration
  def change
    create_table :workgroup_shares do |t|
      t.integer :share_id
      t.integer :workgroup_id

      t.timestamps null: false
    end
  end
end
