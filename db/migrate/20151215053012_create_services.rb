class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :alias
      t.string :kind

      t.timestamps null: false
    end
  end
end
