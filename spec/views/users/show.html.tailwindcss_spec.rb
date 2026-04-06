require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    assign(:user, User.create!(
      email: "user@example.com",
      email_confirm: false,
      password: "password123",
      password_confirmation: "password123",
      first_name: "First Name",
      last_name: "Last Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
  end
end
