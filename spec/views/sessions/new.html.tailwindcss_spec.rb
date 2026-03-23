require 'rails_helper'

RSpec.describe "sessions/new", type: :view do
  before(:each) do
    assign(:session, Session.new(
      start_time: "06:30",
      max_capacity: 1,
      name: "MyString",
      archived_at: "2026-03-23T10:00:00",
      deleted_at: "2026-03-24T10:00:00"
    ))
  end

  it "renders new session form" do
    render

    assert_select "form[action=?][method=?]", sessions_path, "post" do
      assert_select "input[name=?]", "session[start_time]"

      assert_select "input[name=?]", "session[max_capacity]"

      assert_select "input[name=?]", "session[name]"

      assert_select "input[name=?]", "session[archived_at]"

      assert_select "input[name=?]", "session[deleted_at]"
    end
  end
end
