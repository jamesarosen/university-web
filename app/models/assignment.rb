class Assignment < ActiveRecord::Base
  has_many :submissions, :class_name => "Assignment::Submission", 
                         :dependent  => :destroy
  has_many :reviews,     :through    => :submissions
  has_many :activities,  :dependent  => :delete_all
  
  belongs_to :course
  
  accepts_nested_attributes_for :submissions
  
  def submission_for(student)
    submission = submissions.find_or_create_by_user_id(student.id)
    
    if submission.submission_status_id.nil?
      submission.update_attribute(:submission_status_id,
        Assignment::SubmissionStatus.order("sort_order").first) 
    end
    
    submission
  end
  
  def recent_activity(limit=2)
    recent = activities.order("updated_at DESC").limit(limit).reverse
  end
end
