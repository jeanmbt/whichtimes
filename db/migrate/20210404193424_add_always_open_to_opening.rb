class AddAlwaysOpenToOpening < ActiveRecord::Migration[6.0]
  def change
    add_column :openings, :always_open?, :boolean, default: false
  end
end
