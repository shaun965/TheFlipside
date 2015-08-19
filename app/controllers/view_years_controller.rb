class ViewYearsController < ApplicationController

  def edit
    @year = ViewYear.where(user_id: current_user.id, location_id: edit_params[:location_id]).first
    @year.start_year = edit_params[:start_year].to_f
    @year.end_year = edit_params[:end_year].to_f
    @year.save
    redirect_to :back
  end


  private

    def edit_params
      params.permit(:start_year, :end_year, :location_id)
    end
end