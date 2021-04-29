puts " \n ////////   Seeds for Which Hour  //////// \n \n \n \n "
sleep(2)

puts "❌ Deleting previous seeds... \n "
Opening.destroy_all
Company.destroy_all


puts "📐 Setting up necessary methods and variables for iteration...  \n "

weekdays = %w[Mon Tue Wed Thu Fri Sat Sun]
@min = [0, 15, 30, 45, 50].sample
# Set and format times for each company

# Formats the hours example: 06:05
def prepare_format(opening_hours)
  @morning_hours = "#{format '%02d', opening_hours.morning_opens_at_hours}:
  #{format '%02d', opening_hours.morning_opens_at_minutes} - 
  #{format '%02d', opening_hours.morning_closes_at_hours}:
  #{format '%02d', opening_hours.morning_closes_at_minutes}"
  @noon_hours = "#{format '%02d', opening_hours.afternoon_opens_at_hours}:
  #{format '%02d', opening_hours.afternoon_opens_at_minutes} - 
  #{format '%02d', opening_hours.afternoon_closes_at_hours}:
  #{format '%02d', opening_hours.afternoon_closes_at_minutes}"
end

# set morning open and close times
def assign_morning_hours(hours)
  hours.morning_opens_at_hours = rand(6..10)
  hours.morning_opens_at_minutes = @min
  hours.morning_closes_at_hours = rand(10..13)
  hours.morning_closes_at_minutes = @min
end

# set afternoon open and close times
def assign_afternoon_hours(hours)
  hours.afternoon_opens_at_hours = hours.morning_closes_at_hours + 1
  hours.afternoon_opens_at_minutes = @min
  hours.afternoon_closes_at_hours = rand(15..23)
  hours.afternoon_closes_at_minutes = @min
end

# Returns day opening hours formatted for easy reading
def format_hours(morning, noon)
  morning.gsub!(/\s/, '')
  noon.gsub!(/\s/, '')
  morning.gsub!(/-/, ' - ')
  noon.gsub!(/-/, ' - ')
  "#{morning} | #{noon}"
end

# Creating sufixes for more realistic fake names :D
sufix = %w[Healthcare Health Clinics Doctors Associated Gerontology Physiotherapy Care Oncology Cardiology]

puts "🏥 Creating Companies... \n "

# Create 8 Companies
30.times do |i|
  company = Company.create!(name: "#{Faker::Company.name} #{sufix.sample}")
  puts "#{i + 1}. #{company.name}"
end
companies = Company.all

puts " \n \n "
puts "🕒 Creating Company's opening hours... \n "

# Assigns Opening Hours for each Company
companies.each do |company|
  puts " --------------------------------------------------
  #{company.name} opening hours: \n "
  weekdays.each do |day|
    opening_hours = Opening.new(company_id: company.id, day: day)
    opening_hours.day = day
    assign_morning_hours(opening_hours)
    assign_afternoon_hours(opening_hours)
    prepare_format(opening_hours)
    opening_hours.save!
    puts " #{day}: \n #{format_hours(@morning_hours, @noon_hours)}"
  end
  puts "\n \n"
end

# Assign some Sundays as closed_day
sundays = Opening.where(day: 'Sun').sample(15)
sundays.each do |o|
  o.closed_day = true
  o.save
  puts "#️⃣ #{o.company.name} closes now on Sundays \n "
end

# Assign a company as always_open
10.times do
  always_open_company = Company.all.sample
  always_open_opening = Opening.where(company_id: always_open_company.id)
  always_open_opening.each do |o|
    o.always_open = true
    o.save
  end
  puts "#️⃣ #{always_open_company.name} is now 24h \n "
end

puts "//////// Seeds ended! ////////  \n  \n "
