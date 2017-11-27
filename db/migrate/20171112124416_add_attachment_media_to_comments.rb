class AddAttachmentMediaToComments < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.attachment :media
    end
  end

  def self.down
    remove_attachment :comments, :media
  end
end
