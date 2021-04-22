class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end
  
  def show
    @company = Company.find(params[:id])
    @today = Time.now.strftime('%a')
    @tags = clean_show
    @days = %w[ Mon Tue Wed Thu Fri Sat Sun ]
    @sym_days = %i[ mon tue wed thu fri sat sun ]
    @c = 0
    
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
