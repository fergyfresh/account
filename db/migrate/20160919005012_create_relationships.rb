class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :employee_id
      t.integer :supervisor_id

      t.timestamps null: false
    end
    add_index :relationships, :employee_id
    add_index :relationships, :supervisor_id
    add_index :relationships, [:employee_id, :supervisor_id], unique: true
  end
end
