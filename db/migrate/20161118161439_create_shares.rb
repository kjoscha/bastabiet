class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.references :group, index: true, foreign_key: true
      t.string :name, null: false
      t.string :members, array: true, default: []

      t.timestamps null: false
    end
  end
end
