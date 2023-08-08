class Ajax::FavoritesController < ::Ajax::BaseController
  def create
    cookies_favorites = cookies[:favorites].split(',')
    cookies_favorites << params['favorite']
    cookies[:favorites] = cookies_favorites.compact.join(',')
  end

  def destroy
    cookies_favorites = cookies[:favorites].split(',')
    cookies_favorites -= [params['favorite']]
    cookies[:favorites] = cookies_favorites.compact.join(',')

    redirect_to wishlist_path
  end
end
