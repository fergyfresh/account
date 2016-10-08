class AddIsHoursToRecords < ActiveRecord::Migration
  def change
    add_column :records, :isHours, :boolean, :default => false
  end
end
