admin = User.find_or_initialize_by(email: "admin@cf.com")
admin.update!(
  first_name: 'Admin',
  last_name: 'User',
  password: 'Admin@cf',
  password_confirmation: 'Admin@cf',
  is_admin: true
)
