class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :share, index: true, foreign_key: true

      t.string :name
      t.string :email
      t.string :telephone

      t.timestamps null: false
    end
  end
end
