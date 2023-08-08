class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :name_en
      t.text :description
      t.text :description_en

      t.attachment :image

      t.timestamps null: false
    end
  end
end
