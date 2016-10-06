class Relationship < ActiveRecord::Base
  belongs_to :supervisor, class_name: "User"
  belongs_to :employee, class_name: "User"
  validates :supervisor_id, presence: true
  validates :employee_id, presence: true
end
