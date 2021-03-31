class CreateShortenedUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :shortened_urls do |t|
      t.text :url, null: false, length: 2083
      t.string :url_key, limit: 10, null: false
      t.integer :click_count, null: false, default: 0
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :shortened_urls, :url_key, unique: true
    add_index :shortened_urls, :url, length: 2083
    add_index :shortened_urls, [:user_id, :created_at]
  end
end