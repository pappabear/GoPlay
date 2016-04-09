class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.date :published_at
      t.date :expired_at

      t.timestamps null: false
    end
  end
end
