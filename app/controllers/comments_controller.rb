class CommentsController < BaseController
  layout false

  before_action :set_item

  def create
    Comment.create!(comment_params)

    alert = { notice: "Коментарий успешно добавлен" }
  end

  private

  def set_item
    @item = Item.find(params[:product_id])
  end

  def comment_params
    params.require(:comment).permit(:name, :email, :text).merge(item: @item, user: current_user)
  end
end
