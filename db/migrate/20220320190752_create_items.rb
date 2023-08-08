class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :author, index: true, foreign_key: { on_delete: :cascade }
      t.references :item_category, index: true, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :name_en

      t.text :description
      t.text :description_en

      t.float :price

      t.integer :status, null: false, default: 0
      t.boolean :published, null: :false, default: false
      t.boolean :commenting, null: :false, default: false
      t.boolean :promo, null: :false, default: false

      t.timestamps null: false
    end
  end
end
