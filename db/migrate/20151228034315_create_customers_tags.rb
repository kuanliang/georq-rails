class CreateCustomersTags < ActiveRecord::Migration
  def change
    create_table :customers_tags do |t|
      t.integer :customer_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
