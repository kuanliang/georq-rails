class CreateProjectsServices < ActiveRecord::Migration
  def change
    create_table :projects_services do |t|

      t.timestamps null: false
    end
  end
end
