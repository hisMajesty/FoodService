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

  def calendar
    now = Time.now
    year = now.year
    month = now.month
    if params[:year]
      year = params[:year]
    end
    if params[:month]
      month = params[:month]
    end
    set_month_info(month, year)
    render 'month'
  end

  private

  def set_month_info(month, year)
    month_start = Time.zone.local year, month, 1
    month_end = Time.zone.local year, month, Time.days_in_month(month)
    date_range = month_start.to_date..month_end

    date_infos = date_range.map{|d| {
                                      date: d,
                                      ordered: d.mday % 2 == 0
                                    }}

    @month_info = {
      :month => month,
      :year => year,
      :dates => date_infos,
      :today => Time.zone.now.midnight
    }
  end

end
