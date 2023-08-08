class Admin::SlidersController < Admin::BaseController
  def index 
    @sliders = Slider.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @slider = load_slider
  end

  def new
    @slider = Slider.new
  end

  def edit
    @slider = load_slider
  end

  def create
    @slider = Slider.new(slider_params)

    if @slider.save
      redirect_to admin_slider_path(@slider), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@slider.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @slider = load_slider

    if @slider.update(slider_params)
      redirect_to admin_slider_path(@slider), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@slider.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @slider = load_slider

    @slider.destroy

    redirect_to admin_sliders_path, notice: 'Дані видалено'
  end

  private

  def load_slider
    Slider.find(params[:id])
  end

  def slider_params
    params.require(:slider).permit(
      :text_1,
      :text_1_en,
      :text_2,
      :text_2_en,
      :button_title,
      :button_title_en,
      :button_url,
      :image
    )
  end
end