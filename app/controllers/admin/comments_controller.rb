class Admin::CommentsController < Admin::BaseController
  def index
    @comments = Comment.order(created_at: :desc).page(params[:page]).per(10)
  end

  def edit
    @comment = load_comment
  end

  def update
    @comment = load_comment

    if @comment.update(comment_params)
      redirect_to admin_comments_path, notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@comment.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @comment = load_comment

    @comment.destroy

    redirect_to admin_comments_path, notice: 'Дані видалено'
  end

  private

  def load_comment
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :name,
      :email,
      :text,
      :published
    )
  end
end