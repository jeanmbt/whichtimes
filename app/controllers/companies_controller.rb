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

  # Creates a string  to be passed on the view to display each day's opening hours
  def clean_show
    days = %i[ mon tue wed thu fri sat sun ]
    html_days = []
    days.each do |day|
      html_days << "#{@company.find_hours[day][:all_day]}"
    end
    html_days
  end

end
