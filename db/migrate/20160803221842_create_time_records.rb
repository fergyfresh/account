class CreateTimeRecords < ActiveRecord::Migration
  def change
    create_table :time_records do |t|
      t.string :title
      t.date :date
      t.float :hours

      t.timestamps null: false
    end
  end
end
