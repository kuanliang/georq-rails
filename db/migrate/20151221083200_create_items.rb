class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :contract_name
      t.string :invoice_name

      t.timestamps null: false
    end
  end
end
