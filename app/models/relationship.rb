class Relationship < ActiveRecord::Base
  belongs_to :supervisor, class_name: "User"
  belongs_to :employee, class_name: "User"
  belongs_to :project, class_name: "Project"
  validates :supervisor_id, presence: true
  validates :employee_id, presence: true
  validates :project_id, presence: true
end
