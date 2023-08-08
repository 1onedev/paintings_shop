class Admin::ItemCategoriesController < Admin::BaseController
  def show
    @item_category = load_item_category

    @items = Item.where(item_category: @item_category).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @item_category = ItemCategory.new
  end

  def edit
    @item_category = load_item_category
  end

  def create
    @item_category = ItemCategory.new(item_category_params)

    if @item_category.save
      redirect_to admin_item_category_path(@item_category), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@item_category.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @item_category = load_item_category

    if @item_category.update(item_category_params)
      redirect_to admin_item_category_path(@item_category), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@item_category.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @item_category = load_item_category

    Item.where(item_category_id: @item_category.id).update_all(item_category_id: nil, published: false)

    @item_category.destroy

    redirect_to admin_items_path, notice: 'Дані видалено'
  end

  private

  def load_item_category
    ItemCategory.find(params[:id])
  end

  def item_category_params
    params.require(:item_category).permit(
      :name,
      :name_en
    )
  end
end