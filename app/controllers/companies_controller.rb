# Companies
# todo - Make it dry
class CompaniesController < ApplicationController
  # skip_before_action :authenticate_user!, only: %i[index show]
  before_action :authenticate_user!, only: %i[new create edit update review]

  def index
      @companies = policy_scope(Company.all.page params[:page]).order(created_at: :desc)
  end

  def show
    @company = Company.find(params[:id])
    @today = Time.now.strftime('%a')
    @tags = clean_show
    @days = %w[Mon Tue Wed Thu Fri Sat Sun]
    @sym_days = %i[mon tue wed thu fri sat sun]
    @c = 0
    authorize @company
  end

  def new
    if user_signed_in?
      @company = Company.new
    else
      redirect_to new_user_session_path(from: 'add')
    end
  end

  def create
    @company = Company.new(name: params[:company][:name], user: current_user)
    if @company.save
      install_openings(@company)
      redirect_to company_mon_path(@company, day: "mon")
      flash[:notice] = " New Company: \n #{@company.name} was added."
    else
      # redirect_to companies_path(params: 'not-created') # To do: add error message
      flash[:notice] = 'Company not added. '
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    
  end

  def review
    @company = Company.find(params[:company_id])
    @today = Time.now.strftime('%a')
    @tags = clean_show
    @days = %w[Mon Tue Wed Thu Fri Sat Sun]
    @sym_days = %i[mon tue wed thu fri sat sun]
    @c = 0
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

  private

  # Creates a div to be passed on the view to display each day's opening hours
  def install_openings(company)
      @mon = Opening.create(day: 'Mon', company_id: company.id),
      @tue = Opening.create(day: 'Tue', company_id: company.id),
      @wed = Opening.create(day: 'Wed', company_id: company.id),
      @thu = Opening.create(day: 'Thu', company_id: company.id),
      @fri = Opening.create(day: 'Fri', company_id: company.id),
      @sat = Opening.create(day: 'Sat', company_id: company.id),
      @sun = Opening.create(day: 'Sun', company_id: company.id)
  end

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

  
end
