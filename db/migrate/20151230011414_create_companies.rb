class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :company_name
      t.string :company_address
      t.string :company_tel
      t.string :company_fax

      t.timestamps null: false
    end
  end
end
