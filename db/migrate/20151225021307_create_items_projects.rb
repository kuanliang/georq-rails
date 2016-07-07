class CreateItemsProjects < ActiveRecord::Migration
  def change
    create_table :items_projects do |t|
      t.integer :item_id
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
