class User::InfosController < ::User::BaseController
  def show
    set_seo(load_page_seo)
  end

  def edit
    set_seo(load_page_seo)
  end

  def update
    if current_user.update(user_params)
      notice = "#{t :date_save}"

      redirect_to user_infos_path
    else
      alert = { error: "#{t :date_error}" }
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :phone)
  end

  def load_page_seo
     OpenStruct.new(seo_title: "Мій акаунт", seo_description: settings.about_market, image: '/favicon/ou.jpg')
   end
end