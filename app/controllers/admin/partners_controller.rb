class Admin::PartnersController < Admin::BaseController
  def index 
    @partners = Partner.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @partner = load_partner
  end

  def new
    @partner = Partner.new
  end

  def edit
    @partner = load_partner
  end

  def create
    @partner = Partner.new(partner_params)

    if @partner.save
      redirect_to admin_partner_path(@partner), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@partner.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @partner = load_partner

    if @partner.update(partner_params)
      redirect_to admin_partner_path(@partner), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@partner.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @partner = load_partner

    @partner.destroy

    redirect_to admin_partners_path, notice: 'Дані видалено'
  end

  private

  def load_partner
    Partner.find(params[:id])
  end

  def partner_params
    params.require(:partner).permit(
      :name,
      :link,
      :image
    )
  end
end