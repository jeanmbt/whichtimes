# Companies
class CompaniesController < ApplicationController
  def index
    @companies = Company.all.page params[:page]
  end

  def show
    @company = Company.find(params[:id])
    @today = Time.now.strftime('%a')
    @tags = clean_show
    @days = %w[Mon Tue Wed Thu Fri Sat Sun]
    @sym_days = %i[mon tue wed thu fri sat sun]
    @c = 0
  end

  def new
    @company = Company.new

    
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path(company)
      flash[:notice] = " New Company: \n #{@project.title} was added."
    else
      redirect_to companies_path(params: 'not-created')
      flash[:notice] = 'Company not added. '
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    
  end

  private

  # Creates a div to be passed on the view to display each day's opening hours
  def clean_show
    days = %i[ mon tue wed thu fri sat sun ]
    html_days = []
    days.each do |day|
      html_days << "<div clas='morning' style='padding: 0 #{closed?(day, :morning)};text-align: center;'>
      #{@company.find_hours[day][:morning]} </div>
      <div clas='noon' style='padding: 0 #{closed?(day, :noon)};text-align: center;'>#{@company.find_hours[day][:noon]}
      </div>"
    end
    html_days
  end

  # checks if opening is a closed day or 24h day
  def closed?(day, time)
    case @company.find_hours[day][time]
    when 'Closed'
      '35px'
    when '24H'
      '42px'
    else
      '16px'
    end
  end

  # Logic for adding openings when creating a new Company from browser
  def openings_logic
    weekdays = %w[Mon Tue Wed Thu Fri Sat Sun]
    weekdays.each do |day|
      @opening_hours = Opening.new(company_id: @company.id, day: day)
      @opening_hours.day = day
    end
  end
end
