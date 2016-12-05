class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :needed_sum
      t.boolean :show_statistics, default: true
      t.boolean :offer_minimum_active, default: true
      t.boolean :offer_medium_active, default: true
      t.boolean :offer_maximum_active, default: true

      t.timestamps null: false
    end
    Setting.create( needed_sum: 1_000 )
  end
end
