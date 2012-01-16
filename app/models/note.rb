class Note < ActiveRecord::Base
  belongs_to :member
  belongs_to :admin_user

  attr_accessible :body, :member, :member_id, :admin_user, :admin_user_id, :updated_at, :create_at

  validates :body, :member, :presence => true
end
