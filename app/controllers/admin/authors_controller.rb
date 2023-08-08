class Admin::AuthorsController < Admin::BaseController
  def index
    @author_all = Author.order(created_at: :desc).all

    @authors = Author.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @author = load_author

    @author_items = Item.where(author: @author).all

    @order_items = OrderItem.where(item_id: @author_items.ids).all
  end

  def new
    @author = Author.new
  end

  def edit
    @author = load_author
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to admin_author_path(@author), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@author.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @author = load_author

    if @author.update(author_params)
      redirect_to admin_author_path(@author), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@author.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @author = load_author

    Item.where(author_id: @author.id).update_all(author_id: nil, published: false)

    @author.destroy

    redirect_to admin_authors_path, notice: 'Дані видалено'
  end

  private

  def load_author
    Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(
      :name,
      :name_en,
      :description,
      :description_en,
      :image
    )
  end
end