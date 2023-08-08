class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text :text

      t.boolean :viewed, null: false, default: false

      t.timestamps null: false
    end
  end
end
