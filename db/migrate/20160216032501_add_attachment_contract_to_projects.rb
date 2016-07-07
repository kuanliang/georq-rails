class AddAttachmentContractToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :contract
    end
  end

  def self.down
    remove_attachment :projects, :contract
  end
end
