class OpeningsController < ApplicationController

  def new
    @company = Company.find(params[:company_id])
    @all_openings = new_openings_logic
  end

  def create
    @opening = Opening.new(opening_params)
    @company = Company.find(params[:company_id])
    @opening.company = @company
    if @opening.save
      redirect_to companies_path(@company)
      flash[:notice] = " New opening for \n #{@opening.day} was created."
    else
      flash[:notice] = ' New opening not created '
    end
  end

  def edit
    @opening = Opening.find(params[:opening_id])
  end

  def update
    @opening = Opening.find(params[:id])
    if @opening.update
      redirect_to companies_path(@company)
      flash[:notice] = " Opening for \n #{@opening.day} was updated."
    else
      flash[:notice] = ' Opening was not updated '
    end
    redirect_to companies_path
  end
  
  private 

  def opening_params
    params.require(:opening).permit(:company_id, :day, :morning_opens_at_hours,
                                     :morning_opens_at_minutes, :morning_closes_at_hours,
                                     :morning_closes_at_minutes, :afternoon_opens_at_hours, 
                                     :afternoon_opens_at_minutes, :afternoon_closes_at_hours,
                                     :afternoon_closes_at_minutes, :always_open, :closed_day)
  end

  # Logic for adding openings when creating a new Company from browser
  def new_openings_logic
    @all_openings = [
    @mon = Opening.create(day: 'Mon', company_id: @company.id),
    @tue = Opening.create(day: 'Tue', company_id: @company.id),
    @wed = Opening.create(day: 'Wed', company_id: @company.id),
    @thu = Opening.create(day: 'Thu', company_id: @company.id),
    @fri = Opening.create(day: 'Fri', company_id: @company.id),
    @sat = Opening.create(day: 'Sat', company_id: @company.id),
    @sun = Opening.create(day: 'Sun', company_id: @company.id)
    ]
  end
end
