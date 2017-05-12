class AddProjectIdToRecord < ActiveRecord::Migration[5.0]
  def change
    add_column :records, :project_id, :integer
  end
end
