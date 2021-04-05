class OpeningsController < ApplicationController

  def update
    @openings = Opening.find(params[:id])
    @openings.update(opening_params)
    redirect_to companies_path
  end

  def opening_params
    params.require(:openings).permit(:company_id, :day, :morning_opens_at_hours,
                                     :morning_opens_at_minutes, :morning_closes_at_hours,
                                     :morning_closes_at_minutes, :afternoon_opens_at_hours, 
                                     :afternoon_opens_at_minutes, :afternoon_closes_at_hours,
                                     :afternoon_closes_at_minutes, :always_open, :closed_day)
  end
end
