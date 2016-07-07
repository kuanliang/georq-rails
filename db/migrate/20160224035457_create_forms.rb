class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.string :name
      t.string :background
      t.string :background2
      t.string :background3

      t.timestamps null: false
    end
  end
end
