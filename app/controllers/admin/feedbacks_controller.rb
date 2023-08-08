class Admin::FeedbacksController < Admin::BaseController
  def index
    @feedbacks = Feedback.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    @feedback = load_feedback

    @feedback.destroy

    redirect_to admin_feedbacks_path, notice: 'Дані видалено'
  end

  private

  def load_feedback
    Feedback.find(params[:id])
  end
end