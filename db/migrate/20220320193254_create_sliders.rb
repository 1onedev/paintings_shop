class CreateSliders < ActiveRecord::Migration[5.2]
  def change
    create_table :sliders do |t|
      t.text :text_1
      t.text :text_1_en
      t.text :text_2
      t.text :text_2_en
      t.text :text_3
      t.text :text_3_en
      t.string :sale

      t.string :button_title
      t.string :button_title_en
      t.string :button_url

      t.attachment :image

      t.timestamps null: false
    end
  end
end
