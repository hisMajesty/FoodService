class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  # GET /requests
  # GET /requests.json
  def index
    @requests = Request.all
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
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

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @request }
      else
        format.html { render action: 'new' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:user_id, :date)
    end

    def canCreate(request)
    #todo: allow to create requests only in the future
    if Request.find_by date:request[:date]
      return false
    end
    return true
  end
   def canDestroy(request)
    #todo: allow to destroy only request without orders
    true
  end
end
