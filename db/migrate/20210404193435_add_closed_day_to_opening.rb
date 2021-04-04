class AddClosedDayToOpening < ActiveRecord::Migration[6.0]
  def change
    add_column :openings, :closed_day?, :boolean, default: false
  end
end
