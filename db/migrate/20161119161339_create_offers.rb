class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.references :share, index: true, foreign_key: true
      t.integer :amount, null: false

      t.timestamps null: false
    end
  end
end
