class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.string :name_en
      t.text :text
      t.text :text_en

      t.boolean :published, null: false, default: false

      t.attachment :image

      t.timestamps null: false
    end
  end
end
