class AuthorsController < BaseController
  def show
    @author = load_author

    @author_items_not_sold = Item.where(author: @author, status: 0).order(created_at: :desc).all
    @author_items_sold = Item.where(author: @author, status: 1).order(created_at: :desc).all

    set_seo(@author)
  end

  def load_author
    Author.find(params[:id])
  end
end
