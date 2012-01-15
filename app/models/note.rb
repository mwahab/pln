class Note < ActiveRecord::Base
  paginates_per 10
  belongs_to :member

  attr_accessible :body, :commenter, :updated_at, :create_at
end