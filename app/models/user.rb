class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :records
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "supervisor_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "project_id",
                                   dependent:   :destroy
  has_many :employing, through: :active_relationships, source: :employee
  has_many :jobs, through: :active_relationships, source: :project
  has_many :projects
  
  def promote(other_user)
    other_user.update_column(supervisor:true)
  end

  def hire(other_user, project)
    active_relationships.create(employee_id: other_user.id, project_id: project.id)
  end

  def fire(other_user, project)
    active_relationships.find_by(employee_id: other_user.id, project_id: project.id).destroy
  end

  def rostered?(other_user)
    employing.include?(other_user)
  end
end
