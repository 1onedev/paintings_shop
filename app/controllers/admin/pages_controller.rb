class Admin::PagesController < Admin::BaseController
  def notifications
    @messages = Message.order(created_at: :desc).first(5)

    @feedbacks = Feedback.order(created_at: :desc).first(5)

    @comments = Comment.order(created_at: :desc).first(5)
  end

  def page_content
  end
end