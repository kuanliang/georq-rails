class CreateCompaniesItems < ActiveRecord::Migration
  def change
    create_table :companies_items do |t|
      t.integer :company_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
