class AddAttachmentFileToForms < ActiveRecord::Migration
  def self.up
    change_table :forms do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :forms, :file
  end
end
