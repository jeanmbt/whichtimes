class ChangeClosedAndOpenColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :openings, :closed_day?, :closed_day
    rename_column :openings, :always_open?, :always_open
  end
end
