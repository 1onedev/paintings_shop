class BaseController < ApplicationController
  before_action :initialize_cookies_favorites
  before_action :initialize_cookies_items
  
  def initialize_cookies_favorites
    return if cookies[:favorites]
    cookies[:favorites] = { value: '', expires: 1.year.from_now }
  end

  def initialize_cookies_items
    return if cookies[:items]
    cookies[:items] = { value: '', expires: 1.year.from_now }
  end

  def set_seo(page)
    title = page&.name 
    if params[:controller] == "posts"
      description = page&.text
    else
      description = ' ' || page&.description
    end
    image = '' || page.try(:image) || page&.cover.url

    set_meta_tags site: settings.market_name,
                  title: title,
                  reverse: false,
                  description: description,
                  twitter: {
                              title: title,
                              description: description,
                              card: 'summary_large_image',
                              image: { _: image }
                            },
                  og: {
                        title: title,
                        description: description,
                        type: 'website',
                        url: request.original_url,
                        image: { _: image }
                      }
  end
end
