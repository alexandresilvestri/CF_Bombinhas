require 'rails_helper'

RSpec.describe Session, type: :model do
  describe "attributes" do
    it "stores the expected fields" do
      session = described_class.new(
        start_time: "06:30",
        max_capacity: 12,
        name: "Morning Class"
      )

      expect(session.start_time.strftime("%H:%M")).to eq("06:30")
      expect(session.max_capacity).to eq(12)
      expect(session.name).to eq("Morning Class")
    end
  end
end
