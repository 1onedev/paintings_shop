class Ajax::BaseController < ::BaseController
  layout false
  before_action :initialize_cookies_items
  before_action :initialize_cookies_favorites
end
