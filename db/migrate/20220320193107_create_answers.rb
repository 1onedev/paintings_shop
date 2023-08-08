class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :question
      t.text :question_en
      t.text :text
      t.text :text_en

      t.timestamps null: false
    end
  end
end
