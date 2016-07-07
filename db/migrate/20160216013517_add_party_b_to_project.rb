class AddPartyBToProject < ActiveRecord::Migration
  def change
  	add_column :projects, :partyb , :string
  end
end
