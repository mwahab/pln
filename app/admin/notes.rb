ActiveAdmin.register Note do
  filter :member
 
  index do
    column "Date", :sortable => :updated_at do |note|
      pretty_format(note.updated_at.to_date)
    end
    column "Commenter", :commenter
    column "Member", :member, :sortable => false
    column "Note", :body, :sortable => false
    default_actions
  end
end
