class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :switch_locale
  helper_method :settings
  helper_method :favorite_items
  helper_method :cart_items
  helper_method :item_categories

  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_root_path
    else
      user_root_path
    end  
  end

  def after_sign_out_path_for(resource)
    return root_path
  end 

  def settings
    @settings ||= Setting.first_or_create
  end

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def favorite_items
    @favorite_items ||= Item.where(id: cookies[:favorites].split(',')).uniq
  end

  def cart_items
    @cart_items ||= Item.where(id: cookies[:items].split(',')).uniq
  end

  def item_categories
    @item_categories = ItemCategory.order(name: :desc).all
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :email])
  end
end
