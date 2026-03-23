require 'rails_helper'

RSpec.describe "sessions/edit", type: :view do
  let(:session) {
    Session.create!(
      start_time: "06:30",
      max_capacity: 1,
      name: "MyString"
    )
  }

  before(:each) do
    assign(:session, session)
  end

  it "renders the edit session form" do
    render

    assert_select "form[action=?][method=?]", session_path(session), "post" do
      assert_select "input[name=?]", "session[start_time]"

      assert_select "input[name=?]", "session[max_capacity]"

      assert_select "input[name=?]", "session[name]"
    end
  end
end
