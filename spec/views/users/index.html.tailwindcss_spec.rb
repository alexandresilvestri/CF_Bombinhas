require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        id: "",
        email: "Email",
        email_confirm: false,
        password_hash: "Password Hash",
        first_name: "First Name",
        last_name: "Last Name"
      ),
      User.create!(
        id: "",
        email: "Email",
        email_confirm: false,
        password_hash: "Password Hash",
        first_name: "First Name",
        last_name: "Last Name"
      )
    ])
  end

  it "renders a list of users" do
    render
    expect(rendered).to include("Email")
    expect(rendered).to include("Password Hash")
    expect(rendered).to include("First Name")
    expect(rendered).to include("Last Name")
  end
end
