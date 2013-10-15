class RequestsController < ApplicationController

	skip_before_filter :verify_authenticity_token  

	def index
		@requests = Request.all
		render 'list'
	end

	def create
		@request = Request.new
		puts current_user()
		@request.user_id = current_user().id		
		@request.date = params[:date].to_date
		

		respond_to do |format|
			if @request.save	
			  format.js { render :json => "message" }
        	  format.html { redirect_to @request, notice: 'User was successfully created.' }
		      
		      format.json { render json: @request, status: :created, location: @request }
		    else
		      format.html { render action: "new" }
		      format.json { render json: @request.errors, status: :unprocessable_entity }
		    end
		end
	end

end
