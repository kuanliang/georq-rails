class CreateConsultantClasses < ActiveRecord::Migration
  def change
    create_table :consultant_classes do |t|
      t.integer :consultant_id
      t.string :class_content
      t.string :class_date

      t.timestamps null: false
    end
  end
end
