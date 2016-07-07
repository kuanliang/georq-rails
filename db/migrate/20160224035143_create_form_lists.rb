class CreateFormLists < ActiveRecord::Migration
  def change
    create_table :form_lists do |t|
      t.string :form
      t.string :name

      t.timestamps null: false
    end
  end
end
