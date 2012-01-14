ActiveAdmin.register Goal do
  filter :member

  index do
    column "Due Date", :sortable => :duedate do |goal|
      goal.duedate ? pretty_format(goal.duedate.to_date) : '-'
    end
    column "Commenter", :commenter
    column("Complete", :sortable => :complete) {|goal| status_tag(goal.state)}
    column "Member", :member, :sortable => false
    column "Goal", :body, :sortable => false
  end
end
