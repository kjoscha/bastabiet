class AddUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :file, null: false
      t.boolean :public, null: false, default: false

      t.timestamps null: false
    end
  end
end
