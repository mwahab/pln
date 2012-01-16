class Goal < ActiveRecord::Base
  belongs_to :member
  belongs_to :admin_user

  scope :incomplete, lambda { where("complete = ?", false) }
  scope :completed, lambda { where("complete = ?", true) }
  scope :near_due, where(:duedate => Time.now..Time.now.next_month)

  COMPLETE = "complete"
  INCOMPLETE = "incomplete"

  attr_accessible :body, :member, :member_id, :admin_user, :admin_user_id, :complete, :duedate, :updated_at, :create_at

  validates :body, :member, :presence => true

  def state
    self.complete ? COMPLETE : INCOMPLETE
  end
end


