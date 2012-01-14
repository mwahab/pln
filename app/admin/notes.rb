ActiveAdmin.register Note do
  filter :member_lastName, :label => "Family Name", :as => :select, :collection => proc { Member.order("lastName asc").all.collect{ |m| m.lastName }.uniq }
 
  index do
    column "Date", :sortable => :updated_at do |note|
      pretty_format(note.updated_at.to_date)
    end
    column "Last name" do |note|
      note.member.lastName
    end
    column "First name" do |note|
      note.member.firstName
    end
    column "Commenter", :commenter
    column "Note", :body, :sortable => false
  end
end
