class CreateOfficeOpenXmls < ActiveRecord::Migration
  def change
    create_table :office_open_xmls do |t|

      t.timestamps null: false
    end
  end
end
