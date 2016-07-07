class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.integer :audit_id
      t.string :certificate_num
      t.string :certificate_type
      t.date :initial_date
      t.date :issue_date
      t.date :expiration_date
      t.string :status
      t.string :comment

      t.timestamps null: false
    end
  end
end
