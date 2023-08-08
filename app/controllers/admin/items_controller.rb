class Admin::ItemsController < Admin::BaseController
  def index
    @item_all = Item.order(created_at: :desc).all
    
    @items = Item.order(created_at: :desc).page(params[:page]).per(5)

    @item_categories = ItemCategory.order(created_at: :desc).page(params[:page]).per(5)

    @item_materials = ItemMaterial.order(created_at: :desc).page(params[:page]).per(5)
  end

  def show
    @item = load_item

    @order_items = OrderItem.where(item_id: @item.id).all

    @similar_items = SimilarItem.where(similar_id: @item.id).page(params[:page]).per(5)

    @images = @item.images
  end

  def new
    @item = Item.new
  end

  def edit
    @item = load_item
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to admin_item_path(@item), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@item.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @item = load_item

    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@item.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @item = load_item

    @item.destroy

    redirect_to admin_items_path, notice: 'Дані видалено'
  end

  private

  def load_item
    Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :name_en,
      :description,
      :description_en,
      :price,
      :status,
      :published,
      :commenting,
      :promo,
      :item_category_id,
      :author_id,
      :item_material_id,
      similar_items_attributes: [:id, :item_id, :similar_item_id, :_destroy]
    )
  end
end