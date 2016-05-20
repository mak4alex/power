class AddAttachmentAttachmentToHelps < ActiveRecord::Migration
  def self.up
    change_table :helps do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :helps, :attachment
  end
end
