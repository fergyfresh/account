class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :records
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "supervisor_id",
                                  dependent:   :destroy
  has_many :employing, through: :active_relationships, source: :employee

  def hire(other_user)
    active_relationships.create(employee_id: other_user.id)
  end

  def fire(other_user)
    active_relationships.find_by(employee_id: other_user.id).destroy
  end

  def rostered?(other_user)
    employing.include?(other_user)
  end
end
