ActiveAdmin.register Note do
  filter :member
 
  index do
    column "Date", :sortable => :updated_at do |note|
      pretty_format(note.updated_at.to_date)
    end
    column "Member", :member, :sortable => false
    column("Note", :body, :sortable => false) {|note| snippet(note.body)}
    default_actions
  end

    show :title => "" do
    attributes_table_for note do
      row("Date") { pretty_format(note.updated_at.to_date) }
      row("Member") { link_to(note.member.name, admin_member_path(note.member)) }
      row("Updated By") { note.admin_user }
      row("Note") { note.body }
      row("Created") { pretty_format(note.created_at) }
      row("Updated") { pretty_format(note.updated_at) }
    end
  end

  form :partial => "form"
end
