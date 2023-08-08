class Admin::SettingsController < Admin::BaseController
  def edit
  end

  def update
    if settings.update!(settings_params)
      redirect_to edit_admin_settings_path, notice: 'Налаштування змінено!'
    else
      redirect_to :back, flash: { error: 'Помилка!' }
    end
  end

  private

  def settings_params
    params.require(:setting).permit(
      :logo, 
      :market_name,
      :market_name_en,
      :about_market,
      :about_market_en,
      :phones,
      :emails,
      :adresses,
      :adresses_en,
      :time_work,
      :cart_location,
      :social_links
    )
  end
end