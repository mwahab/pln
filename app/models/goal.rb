class Goal < ActiveRecord::Base
  belongs_to :member

  COMPLETE = "complete"
  INCOMPLETE = "incomplete"

  attr_accessible :updated_at, :create_at

  def state
    self.complete ? COMPLETE : INCOMPLETE
  end
end
