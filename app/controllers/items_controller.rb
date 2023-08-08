class ItemsController < BaseController
  def show
    @item = load_item

    @comments = Comment.where(item_id: @item.id).order(created_at: :desc).page(params[:page]).per(5)

    @similar_items = SimilarItem.where(similar_id: @item.id).limit(4)

    @similar_item_null = Item.where(item_category: @item.item_category).sample(4)

    set_seo(@item)
  end

  def load_item
    Item.published.find(params[:id])
  end
end
