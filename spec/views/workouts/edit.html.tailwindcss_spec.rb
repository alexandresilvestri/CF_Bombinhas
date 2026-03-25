require 'rails_helper'

RSpec.describe "workouts/edit", type: :view do
  let(:workout) {
    Workout.create!(
      tenant: nil,
      name: "MyString",
      max_capacity: 1
    )
  }

  before(:each) do
    assign(:workout, workout)
  end

  it "renders the edit workout form" do
    render

    assert_select "form[action=?][method=?]", workout_path(workout), "post" do
      assert_select "input[name=?]", "workout[tenant_id]"

      assert_select "input[name=?]", "workout[name]"

      assert_select "input[name=?]", "workout[max_capacity]"
    end
  end
end
