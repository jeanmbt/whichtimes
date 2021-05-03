class OpeningsController < ApplicationController

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

  # def edit
  #   @opening = Opening.find(params[:opening_id])
  # end

  def update
    @opening = Opening.find(params[:id])
    @company = Company.find(params[:company_id])
    if set_opening_day
      
      flash[:notice] = " Opening for \n #{@opening.day} was updated."
    else
      flash[:notice] = ' Opening was not updated ' #todo error message
    end
    #redirect_to companies_path
  end
  
  # todo: get previous page for a back button
  def mon
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Mon', company_id: @company.id)
  end 

  def tue
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Tue', company_id: @company.id)
  end 
  
  def wed
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Wed', company_id: @company.id)
  end 

  def thu
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Thu', company_id: @company.id)
  end 

  def fri
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Fri', company_id: @company.id)
  end 

  def sat
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Sat', company_id: @company.id)
  end 

  def sun
    @company = Company.find(params[:company_id])
    @opening = Opening.find_by(day: 'Sun', company_id: @company.id)
  end 
  


  private 
  def redirect_to_next_day
    # day: @opening.day.downcase
  end

  def set_opening_day
    # todo make this dry ASAP :O :(
    case @opening.day
    # todo redirect_to company_tue_path(@company, day: #{@opening.next.day.downcase}) then case when won't be necessary (.next?)
    when 'Mon'
      # todo: make from: review work
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        @opening.update(opening_params)
        redirect_to company_tue_path(@company, day: 'tue')
      end
    when 'Tue'
      # params[:from] = review WORKED HERE, WHY?
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        redirect_to company_wed_path(@company, day: 'wed')
      end
    when 'Wed'
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        redirect_to company_thu_path(@company, day: 'thu')
      end
    when 'Thu'
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        redirect_to company_fri_path(@company, day: 'fri')
      end
    when 'Fri'
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        redirect_to company_sat_path(@company, day: 'sat')
      end
    when 'Sat'
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        redirect_to company_sun_path(@company, day: 'sun')
      end
    when 'Sun'
      @opening.update(opening_params)
      if params[:from] = 'review'
        redirect_to company_review_path(@company)
      else
        redirect_to company_review_path(@company)
      end
    end
  end

  def opening_params
    params.require(:opening).permit(:company_id, :day, :morning_opens_at_hours,
                                     :morning_opens_at_minutes, :morning_closes_at_hours,
                                     :morning_closes_at_minutes, :afternoon_opens_at_hours, 
                                     :afternoon_opens_at_minutes, :afternoon_closes_at_hours,
                                     :afternoon_closes_at_minutes, :always_open, :closed_day)
  end

end
