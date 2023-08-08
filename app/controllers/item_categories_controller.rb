class ItemCategoriesController < BaseController
  def index
    @item_categories = ItemCategory.order(name: :desc).all

    @items = ItemsQuery.new(params.to_unsafe_h).all.page(params[:page]).per(12)

    @item_materials = ItemMaterial.order(name: :asc).all

    set_seo(load_page_seo)
  end

  def show
    @item_category = load_item_category

    @item_categories = ItemCategory.order(name: :desc).all

    @items = ItemsQuery.new(params.to_unsafe_h).all.page(params[:page]).per(12)

    @item_materials = ItemMaterial.order(name: :asc).all

    set_seo(@item_category)
  end

  private

  def load_page_seo
    OpenStruct.new(seo_title: "#{t 'all_paintings'}", seo_description: settings.about_market, image: '/favicon/ou.jpg')
  end

  def load_item_category
    ItemCategory.find(params[:id])
  end
end