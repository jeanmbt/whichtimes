class OpeningsController < ApplicationController

  def new
    @opening = Opening.new
  end

  def create
    @opening = Opening.new(opening_params)
    @company = Company.find(params[:company_id])
    @opening.company = @company
    if @opening.save
      redirect_to companies_path(@company)
      flash[:notice] = " New opening \n #{@project.title} was created."
    else
      flash[:notice] = ' New opening not created '
    end
  end

  def edit
    @openings = Opening.find(params[:id])
  end

  def update
    if @opening.update
      redirect_to companies_path(@company)
      flash[:notice] = " Opening \n #{@project.title} was updated."
    else
      flash[:notice] = ' Opening was not updated '
    end
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
