class AddApprovedToRecords < ActiveRecord::Migration
  def change
    add_column :records, :approved, :boolean, :default => false
  end
end
