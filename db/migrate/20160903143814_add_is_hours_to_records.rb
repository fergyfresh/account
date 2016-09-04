class AddIsHoursToRecords < ActiveRecord::Migration
  def change
    add_column :records, :isHours, :boolean
  end
end
