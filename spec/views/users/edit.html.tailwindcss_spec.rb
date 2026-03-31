require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  let(:user) {
    User.create!(
      id: "",
      email: "MyString",
      email_confirm: false,
      password_hash: "MyString",
      first_name: "MyString",
      last_name: "MyString"
    )
  }

  before(:each) do
    assign(:user, user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(user), "post" do
      assert_select "input[name=?]", "user[id]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[email_confirm]"

      assert_select "input[name=?]", "user[password_hash]"

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"
    end
  end
end
