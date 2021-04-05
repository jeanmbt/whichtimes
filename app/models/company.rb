# Be sure to restart your server when you modify this file.
class Company < ApplicationRecord

  # returns all openings associated

  # Allows to fetch data accordingly
  # Company.find_hours[:mon][:morning] => 10:00 - 12:00
  # todo change to class!
  def find_hours
    { mon:
      {
        all_day: match_time('Mon', 'allday'),
        morning: match_time('Mon', 'morning'),
        noon: match_time('Mon', 'noon'),
        day: 'Mon'
      },
      tue: {
        all_day: match_time('Tue', 'allday'),
        morning: match_time('Tue', 'morning'),
        noon: match_time('Tue', 'noon'),
        day: 'Tue'
      },
      wed: { 
        all_day: match_time('Wed', 'allday'),
        morning: match_time('Wed', 'morning'),
        noon: match_time('Wed', 'noon'),
        day: 'Wed'
      },
      thu: {
        all_day: match_time('Thu', 'allday'),
        morning: match_time('Thu', 'morning'),
        noon: match_time('Thu', 'noon'),
        day: 'Thu'
      },
      fri: {  
        all_day: match_time('Fri', 'allday'),
        morning: match_time('Fri', 'morning'),
        noon: match_time('Fri', 'noon'),
        day: 'Fri'
      },
      sat: { 
        all_day: match_time('Sat', 'allday'),
        morning: match_time('Sat', 'morning'),
        noon: match_time('Sat', 'noon'),
        day: 'Sat'
      },
      sun: { 
        all_day: match_time('Sun', 'allday'),
        morning: match_time('Sun', 'morning'),
        noon: match_time('Sun', 'noon'),
        day: 'Sun'
      },
      all_openings: display_all_openings
    }
  end
  
  private

  # checks if the Opening is a Normal day, a Closed day or a 24H day.
  def check_hour(o)
    if o.closed_day
      'Closed'
    elsif o.always_open
      '24H'
    else
      true
    end
  end

  # Return formatted hours
  def return_hours(time, o)
    case time
    when 'morning'
      morning_format(o)
    when 'noon'
      noon_format(o)
    when 'allday'
      allday_format(o)
    end
  end

  # Used on find_hours method
  # day = 'Mon', time = 'morning'...
  def match_time(day, time)
    o = Opening.find_by(day: day, company_id: self.id)
    if check_hour(o) == true
      return_hours(time, o)
    else
      check_hour(o)
    end
  end

  def display_all_openings
    hours_array = []
    all_hours = Opening.where(company_id: self.id)
    all_hours.each do |o|
      if check_hour(o) == true
        hours_array << "#{o.day}:  #{ morning_format(o)} | #{noon_format(o)}"
      else
        check_hour(o)
      end
    end
    hours_array
  end

  # Formats the hours example: 06:05 
  def morning_format(o)
    morning_hours = "#{format '%02d', o.morning_opens_at_hours}:
    #{format '%02d', o.morning_opens_at_minutes} - 
    #{format '%02d', o.morning_closes_at_hours}:
    #{format '%02d', o.morning_closes_at_minutes}"
    morning_hours.gsub!(/\s/, '')
    morning_hours.gsub!(/-/, ' - ')
  end

  def noon_format(o)
    noon_hours = "#{format '%02d', o.afternoon_opens_at_hours}:
    #{format '%02d', o.afternoon_opens_at_minutes} - 
    #{format '%02d', o.afternoon_closes_at_hours}:
    #{format '%02d', o.afternoon_closes_at_minutes}"
    noon_hours.gsub!(/\s/, '')
    noon_hours.gsub!(/-/, ' - ')
  end

  # Returns day opening hours formatted for easy reading
  def allday_format(o)
    "#{morning_format(o)} | #{noon_format(o)}"
  end
  
end
