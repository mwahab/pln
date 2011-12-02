ActiveAdmin.register AdminUser do
  menu :label => "Admin users"

  filter :email

  index do
    column :email
    column :created_at
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end 

  show do
    panel "Admin User Details" do
      attributes_table_for admin_user do
        row("Email") { admin_user.email }
        row("Created At") { l(admin_user.created_at, :format => :long) }
        row("Last Signed In At") { l(admin_user.last_sign_in_at, :format => :long) if admin_user.last_sign_in_at }
        row("Sign In Count") { admin_user.sign_in_count || 0 }
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.buttons
  end
end
