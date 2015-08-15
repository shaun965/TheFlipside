class LocationsController < ApplicationController

  def create

    # Use the entire google map object to check if modify

    if @location = Location.where(longitude: location_params[:longitude], lattitude: location_params[:lattitude]).first
      render json: { id: @location.id.to_s } , status: 200
      @history = History.new(history_params)
      @history.save
    else
      @location = Location.new(location_params)
      if @location.save
        render json: { id: @location.id.to_s }, status: 201
      else       
       render json: @location.errors, status: :unprocessable_entity 
      end
      @history = History.new(history_params)
      @history.save
    end

    #redirect_to :action => "show", :id => @location.id

  end


  def show
    if !current_user
      redirect_to new_user_session_path
    end
    @location = Location.where(id: params[:id]).first
    @post = Post.new
    @posts = @location.posts
    @comment = Comment.new
  end

  def show_image
    @user = User.find(params[:id])
    send_data @user.image_binary, :type => 'image/png',:disposition => 'inline'
  end


private

  def location_params
    params.permit(:longitude, :lattitude, :dir_longitude, :dir_lattitude)
  end

  def history_params
    params.permit(:user_id, :address).merge(location_id: @location.id)
  end

end