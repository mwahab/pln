class Goal < ActiveRecord::Base
  belongs_to :member

  COMPLETE = "complete"
  INCOMPLETE = "incomplete"

  attr_accessible :body, :commenter, :complete, :duedate, :updated_at, :create_at

  def state
    self.complete ? COMPLETE : INCOMPLETE
  end
end
