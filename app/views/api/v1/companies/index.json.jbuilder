json.array! @companies do |company|
  json.extract! company, :id, :name, :opening_hours, :user
end