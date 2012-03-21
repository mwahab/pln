ActiveAdmin.register Note do
  filter :member
 
  index do
    column "Member", :member, :sortable => false    
    column "Date", :sortable => :updated_at do |note|
      pretty_format(note.updated_at.to_date)
    end
    column("Note", :body, :sortable => false) {|note| snippet(note.body)}
    default_actions
  end

    show :title => "" do
    attributes_table_for note do
      row("Member") { link_to(note.member.name, admin_member_path(note.member)) }      
      row("Date") { pretty_format(note.updated_at.to_date) }
      row("Note") { note.body }
      row("Updated By") { note.admin_user }      
      row("Created") { pretty_format(note.created_at) }
      row("Updated") { pretty_format(note.updated_at) }
    end
  end

  form :partial => "form"
end
