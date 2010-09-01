class Course < ActiveRecord::Base
  has_many :course_memberships, :dependent => :destroy
  has_many :students, :through => :course_memberships
  
  validates_presence_of :name
  validates_uniqueness_of :name
end