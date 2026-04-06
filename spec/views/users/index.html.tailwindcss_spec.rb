require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        email: "user1@example.com",
        email_confirm: false,
        password: "password123",
        password_confirmation: "password123",
        first_name: "First Name",
        last_name: "Last Name"
      ),
      User.create!(
        email: "user2@example.com",
        email_confirm: false,
        password: "password123",
        password_confirmation: "password123",
        first_name: "First Name",
        last_name: "Last Name"
      )
    ])
  end

  it "renders a list of users" do
    render
    expect(rendered).to include("Email")
    expect(rendered).to include("First Name")
    expect(rendered).to include("Last Name")
  end
end
