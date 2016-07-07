class CreateProjectsItems < ActiveRecord::Migration
  def change
    create_table :projects_items do |t|

      t.timestamps null: false
    end
  end
end
