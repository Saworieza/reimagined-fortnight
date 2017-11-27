class CreateMentions < ActiveRecord::Migration[5.0]
  def change
    create_table :mentions do |t|

      t.timestamps
    end
  end
end
