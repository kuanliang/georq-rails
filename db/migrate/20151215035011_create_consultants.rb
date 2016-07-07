class CreateConsultants < ActiveRecord::Migration
  def change
    create_table :consultants do |t|
      t.string :consultant_id
      t.integer :project_id
      t.string :contract_date

      t.timestamps null: false
    end
  end
end
