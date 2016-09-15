class AddNameToRecords < ActiveRecord::Migration
  def change
    add_column :records, :name, :string
  end
end
