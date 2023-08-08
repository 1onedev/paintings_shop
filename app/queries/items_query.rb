class ItemsQuery
  def initialize(params)
    @filter = params.delete_if { |_param, value| value.blank? }.with_indifferent_access
    
    if params[:controller] == "item_categories" && params[:action] == "show"
      @relation = Item.where(item_category_id: params[:id]).published.all
    else 
      @relation = Item.published.all
    end
  end

  def all
    apply_filters

    @relation
  end

  private

  def apply_filters
    apply_search
    apply_ordering
    apply_material
  end

  def apply_search
    @relation = @relation.search(@filter[:q])
  end

  def apply_ordering
    return unless @filter.key?(:sorting)

    @relation = case @filter[:sorting]
                when 'name-asc'   then @relation.order(name: :asc)
                when 'name-desc'  then @relation.order(name: :desc)
                when 'price-asc'  then @relation.order(price: :asc)
                when 'price-desc' then @relation.order(price: :desc)
                else @relation.order(created_at: :desc)
                end
  end

  def apply_material
    return if @filter[:item_material].blank?

    @relation = @relation.where(item_material: @filter[:item_material])
  end
end