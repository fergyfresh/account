class AddContractToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :contract, :text
  end
end
