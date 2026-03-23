require 'rails_helper'

RSpec.describe "sessions/show", type: :view do
  before(:each) do
    assign(:session, Session.create!(
      start_time: "06:30",
      max_capacity: 2,
      name: "Name",
      archived_at: "2026-03-23T10:00:00",
      deleted_at: "2026-03-24T10:00:00"
    ))
  end

  it "renders the session attributes" do
    render

    expect(rendered).to match(/06:30/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2026-03-23 10:00:00/)
    expect(rendered).to match(/2026-03-24 10:00:00/)
  end
end
