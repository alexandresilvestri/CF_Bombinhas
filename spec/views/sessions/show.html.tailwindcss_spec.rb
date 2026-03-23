require 'rails_helper'

RSpec.describe "sessions/show", type: :view do
  before(:each) do
    assign(:session, Session.create!(
      start_time: "06:30",
      max_capacity: 2,
      name: "Name"
    ))
  end

  it "renders the session attributes" do
    render

    expect(rendered).to match(/06:30/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
  end
end
