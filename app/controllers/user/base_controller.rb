class User::BaseController < ::BaseController
  before_action :authenticate_user!
end