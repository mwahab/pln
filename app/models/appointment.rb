class Appointment < ActiveRecord::Base
  belongs_to :member
  belongs_to :admin_user

  scope :near_due, where(:duedate => Time.now..Time.now.next_month)
  scope :future, lambda { where("duedate >= ?", Time.now) }
  scope :past, lambda { where("duedate < ?", Time.now) }

  FUTURE = "future"
  PAST = "past"

  attr_accessible :body, :member, :member_id, :admin_user, :admin_user_id, :complete, :duedate, :location, :updated_at, :create_at

  validates :body, :member, :location, :duedate, :presence => true

  def state
    self.duedate < Time.now ? PAST : FUTURE
  end
end
