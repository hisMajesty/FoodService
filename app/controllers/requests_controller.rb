class RequestsController < ApplicationController

	skip_before_filter :verify_authenticity_token  

	def index
		@requests = Request.all
		render 'list'
	end

	def new
		@request = Request.new
		puts current_user()
		@request.user_id = current_user().id		
		@request.date = params[:date].to_date
		

		respond_to do |format|
			if canCreate(@request) && @request.save
		      format.json { render json: @request, status: :created, location: @request }
		    else
		      format.html { render action: "new" }
		      format.json { render json: @request.errors, status: :unprocessable_entity }
		    end
		end
  end

  def canCreate(request)
    #todo: allow to create requests only in the future
    if Request.find_by date:request[:date]
      return false
    end
    return true
  end

  def destroy
    @request = Request.find(params[:id])

    respond_to do |format|
      if canDestroy @request && @request.destroy!
        format.json { render :nothing => true,  status: :no_content }
      else
        format.json { render :nothing => true,  status: :forbidden }
      end
    end
  end

  def canDestroy(request)
    #todo: allow to destroy only request without orders
    true
  end

end
