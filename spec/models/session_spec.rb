require 'rails_helper'

RSpec.describe Session, type: :model do
  describe "attributes" do
    it "stores the expected fields" do
      session = described_class.new(
        start_time: "06:30",
        max_capacity: 12,
        name: "Morning Class",
        archived_at: Time.zone.parse("2026-03-23 10:00:00"),
        deleted_at: Time.zone.parse("2026-03-24 10:00:00")
      )

      expect(session.start_time.strftime("%H:%M")).to eq("06:30")
      expect(session.max_capacity).to eq(12)
      expect(session.name).to eq("Morning Class")
      expect(session.archived_at).to eq(Time.zone.parse("2026-03-23 10:00:00"))
      expect(session.deleted_at).to eq(Time.zone.parse("2026-03-24 10:00:00"))
    end
  end
end
