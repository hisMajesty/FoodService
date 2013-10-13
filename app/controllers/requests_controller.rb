class RequestsController < ApplicationController

	def index
		@requests = Request.all
		render 'list'
	end

	def new
		request = Request.new
		request.user_id = current_user().id		
		request.date = params[:date].to_date
		request.save

		redirect_to '/requests'
	end
end
