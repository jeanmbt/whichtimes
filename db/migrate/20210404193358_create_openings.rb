class CreateOpenings < ActiveRecord::Migration[6.0]
  def change
    create_table :openings do |t|
      t.references :company, null: false, foreign_key: true
      t.string :day
      t.integer :morning_opens_at_hours
      t.integer :morning_opens_at_minutes
      t.integer :morning_closes_at_hours
      t.integer :morning_closes_at_minutes
      t.integer :afternoon_opens_at_hours
      t.integer :afternoon_opens_at_minutes
      t.integer :afternoon_closes_at_hours
      t.integer :afternoon_closes_at_minutes

      t.timestamps
    end
  end
end
