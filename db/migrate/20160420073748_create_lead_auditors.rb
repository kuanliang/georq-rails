class CreateLeadAuditors < ActiveRecord::Migration
  def change
    create_table :lead_auditors do |t|

      t.timestamps null: false
    end
  end
end
