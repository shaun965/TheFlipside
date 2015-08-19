class LocationsController < ApplicationController

  def create

    # Use the entire google map object to check if modify

    if @location = Location.where(longitude: location_params[:longitude], lattitude: location_params[:lattitude]).first
      render json: { id: @location.id.to_s } , status: 200
      @history = History.new(history_params)
      @history.save
      if @location.view_year.where(user_id: current_user.id).first == nil
        @year = ViewYear.new(view_year_params)
        @year.save
      end
    else
      @location = Location.new(location_params)
      if @location.save
        render json: { id: @location.id.to_s }, status: 201
      else       
       render json: @location.errors, status: :unprocessable_entity 
      end
      @history = History.new(history_params)
      @history.save
      @year = ViewYear.new(view_year_params)
      @year.save
    end



    #redirect_to :action => "show", :id => @location.id

  end


  def show
    if !current_user
      redirect_to new_user_session_path
    else
      @location = Location.where(id: params[:id]).first
      @post = Post.new
      @posts = @location.posts
      @comment = Comment.new
      @history = @location.history.where(user_id: current_user.id).last
      @year = @location.view_year.where(user_id: current_user.id).first
      if @location.view_year.where(user_id: current_user.id).first == nil
        @year = ViewYear.new(view_year_params.merge(user_id: current_user.id))
        @year.save
      end
    end
  end

  def show_image
    @user = User.find(params[:id])
    send_data @user.image_binary, :type => 'image/png',:disposition => 'inline'
  end


  def edit
    if @location = Location.where(dir_longitude: edit_params[:dir_longitude], lattitude: edit_params[:lattitude]).first
      render json: { id: @location.id.to_s } , status: 200

      if edit_params[:zoom] != nil
        @location.zoom = edit_params[:zoom]
      end
      if edit_params[:heading] != nil
        @location.heading = edit_params[:heading]
      end
      if edit_params[:pitch] != nil
        @location.pitch = edit_params[:pitch]
      end
      
      @location.save
    end


  end


private

  def location_params
    params.permit(:longitude, :lattitude, :dir_longitude, :dir_lattitude)
  end

  def history_params
    params.permit(:user_id, :address).merge(location_id: @location.id)
  end

  def edit_params
    params.permit(:zoom, :heading, :pitch, :lattitude, :dir_longitude)
  end

  def view_year_params
    params.permit(:user_id).merge(location_id: @location.id)
  end



end