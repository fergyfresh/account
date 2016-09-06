class AddIsHoursToUsers < ActiveRecord::Migration
  def change
    add_column :users, :isHours, :boolean
  end
end
