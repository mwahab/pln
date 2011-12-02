ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

  section "Recently Updated Members", :priority => 1 do
    table_for Member.order('updated_at desc').limit(10).each do |member|
      column("Date") { |member| l(member.updated_at, :format => :long) }
      column("Name") { |member| link_to(member.firstName + " " + member.lastName, admin_member_path(member)) }
    end
  end

  section "Incomplete Profiles", :priority => 2 do
    incomplete = Member.all.select { |m| m.incomplete? }
    table_for incomplete.each do |member|
      column("Last Updated") { |member| l(member.updated_at, :format => :long) }
      column("Name") { |member| link_to(member.firstName + " " + member.lastName, admin_member_path(member)) }
    end
  end

  # section "Recently Diagnosed Members", :priority => 2 do
  #   table_for Member.order('dateDiagnosis desc').limit(10).each do |member|
  #     column("Date") { |member| l(member.dateDiagnosis, :format => :long) }
  #     column("Name") { |member| link_to(member.firstName + " " + member.lastName, admin_member_path(member)) }
  #   end
  # end

end
