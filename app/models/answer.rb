class Answer < ApplicationRecord
  def question
    if I18n.locale == :en && question_en.present?
      question_en
    else
      super
    end
  end

  def text
    if I18n.locale == :en && text_en.present?
      text_en
    else
      super
    end
  end
end