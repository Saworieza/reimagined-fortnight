class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.text :body
      t.integer :tweet_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
