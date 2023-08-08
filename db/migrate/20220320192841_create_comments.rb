class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
      t.references :item, index: true, foreign_key: { on_delete: :cascade }
      t.string :name
      t.string :email
      t.text :text

      t.boolean :viewed, null: false, default: false
      t.boolean :published, null: false, default: false

      t.timestamps null: false
    end
  end
end
