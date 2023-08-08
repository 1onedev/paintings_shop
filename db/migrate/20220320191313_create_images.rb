class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :imageable, polymorphic: true, index: true

      t.attachment :file
      t.integer :position, null: false, default: 0

      t.timestamps null: false
    end
  end
end
