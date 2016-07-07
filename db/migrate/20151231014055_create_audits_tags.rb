class CreateAuditsTags < ActiveRecord::Migration
  def change
    create_table :audits_tags do |t|

      t.timestamps null: false
    end
  end
end
