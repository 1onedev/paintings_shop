class CreateSimilarItems < ActiveRecord::Migration[5.2]
  def change
    create_table :similar_items do |t|
      t.references :item, index: true, foreign_key: true, null: false
      t.references :similar, foreign_key: { to_table: :items, on_delete: :cascade }, index: true

      t.timestamps null: false
    end
  end
end
