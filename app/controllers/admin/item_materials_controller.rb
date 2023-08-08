class Admin::ItemMaterialsController < Admin::BaseController
  def show
    @item_material = load_item_material

    @items = Item.where(item_material: @item_material).order(created_at: :desc).page(params[:page]).per(10)
  end

  def new
    @item_material = ItemMaterial.new
  end

  def edit
    @item_material = load_item_material
  end

  def create
    @item_material = ItemMaterial.new(item_material_params)

    if @item_material.save
      redirect_to admin_item_material_path(@item_material), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@item_material.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @item_material = load_item_material

    if @item_material.update(item_material_params)
      redirect_to admin_item_material_path(@item_material), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@item_material.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @item_material = load_item_material

    Item.where(item_material: @item_material).update_all(item_material: nil, published: false)

    @item_material.destroy

    redirect_to admin_items_path, notice: 'Дані видалено'
  end

  private

  def load_item_material
    ItemMaterial.find(params[:id])
  end

  def item_material_params
    params.require(:item_material).permit(
      :name,
      :name_en
    )
  end
end