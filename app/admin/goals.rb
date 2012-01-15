ActiveAdmin.register Goal do
  filter :member
  filter :complete, :as => :select, :collection => [["Yes", true], ["No", false]]

  index do
    column "Due Date", :sortable => :duedate do |goal|
      goal.duedate ? pretty_format(goal.duedate.to_date) : 'N/A'
    end
    # column "Commenter", :commenter
    column("Status", :sortable => :complete) {|goal| status_tag(goal.state)}
    column "Member", :member, :sortable => false
    column("Goal", :body, :sortable => false) {|goal| snippet(goal.body)}
    default_actions
  end

  show :title => "" do
    attributes_table_for goal do
      row("Status") { status_tag(goal.state) }
      row("Due Date") { goal.duedate ? pretty_format(goal.duedate) : 'N/A' }
      row("Member") { link_to(goal.member.name, admin_member_path(goal.member)) }
      row("Commenter") { goal.commenter }
      row("Goal") { goal.body }
      row("Created") { pretty_format(goal.created_at) }
      row("Updated") { pretty_format(goal.updated_at) }

    end
  end
end
