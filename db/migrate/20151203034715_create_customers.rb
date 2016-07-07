class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_num
      t.string :identification_num
      t.string :customer_chi
      t.string :customer_eng
      t.string :owner
      t.integer :staff_num
      t.integer :site_num
      t.string :mr_chi
      t.string :mr_eng
      t.string :mr_pos
      t.string :fax_num
      t.string :contact_tel
      t.string :contact_email
      t.string :contact_ppl
      t.string :contact_addr
      t.string :office_addr_chi
      t.string :office_addr_eng
      t.string :factory_addr_cht
      t.string :factory_addr_eng
      t.string :level
      t.text :comment

      t.timestamps null: false
    end
  end
end
