class HomeController < ApplicationController
  before_action :check_if_authorised

  def check_if_authorised
      unless current_user
        flash[:warning] = 'not authorized!'
        redirect_to root_path
      end
  end

  def index

  end


end
