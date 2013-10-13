class MonthsController < ApplicationController
  before_action :check_if_authorised

  def check_if_authorised
    unless current_user
      flash[:warning] = 'not authorized!'
      redirect_to root_path
    end
  end

  def index
    now = Time.now
    year = now.year
    month = now.month


    
    if params[:year]
      year = Integer(params[:year])
    end
    if params[:month]
      month = Integer(params[:month])
    end
    set_month_info(month, year)
    
    
    render 'month'
  end

  private

  def set_month_info(month, year)
    month_start = Time.zone.local year, month, 1
    month_end = Time.zone.local year, month, Time.days_in_month(month)
    date_range = month_start.to_date..month_end.to_date
    selected_month = Date.new(year, month)
    this_month_requests = Hash[(current_user().requests.where(:date => selected_month..selected_month >> 1)).map { |r| [r.date, r]}]

    date_infos = date_range.map{|d| {
        date: d,
        request: this_month_requests[d]
    }}
    selected_month = Date.new(year, month)
    

    prev_month = month -1
    prev_year = year
    if prev_month == 0
      prev_month = 12
      prev_year = year -1
    end

    next_month = month + 1
    next_year = year
    if next_month == 13
      next_month = 1
      next_year = year + 1
    end

    @month_info = {
        :month => month,
        :year => year,
        :prev_month => prev_month,
        :prev_year => prev_year,
        :next_month => next_month,
        :next_year => next_year,
        :dates => date_infos,
        :today => Time.zone.now.midnight
    }
  end

end
