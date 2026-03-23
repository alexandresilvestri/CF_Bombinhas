require 'rails_helper'

RSpec.describe "sessions/index", type: :view do
  before(:each) do
    assign(:sessions, [
      Session.create!(
        start_time: "06:30",
        max_capacity: 2,
        name: "Morning Class"
      ),
      Session.create!(
        start_time: "08:00",
        max_capacity: 2,
        name: "Evening Class"
      )
    ])
  end

  it "renders a list of sessions" do
    render

    expect(rendered).to include("Morning Class")
    expect(rendered).to include("Evening Class")
    expect(rendered.scan("Max capacity:").size).to eq(2)
    expect(rendered.scan("Show").size).to eq(2)
  end
end
