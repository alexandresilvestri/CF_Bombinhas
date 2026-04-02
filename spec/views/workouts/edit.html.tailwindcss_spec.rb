require 'rails_helper'

RSpec.describe "workouts/edit", type: :view do
  let(:gym) { Gym.create!(name: "Test Gym") }
  let(:workout) {
    Workout.create!(
      gym: gym,
      name: "MyString",
      warm_up: "MyText",
      skill: "MyText",
      wod: "MyText"
    )
  }

  before(:each) do
    assign(:workout, workout)
  end

  it "renders the edit workout form" do
    render

    assert_select "form[action=?][method=?]", workout_path(workout), "post" do
      assert_select "input[name=?]", "workout[gym_id]"

      assert_select "input[name=?]", "workout[name]"

      assert_select "textarea[name=?]", "workout[warm_up]"

      assert_select "textarea[name=?]", "workout[skill]"

      assert_select "textarea[name=?]", "workout[wod]"
    end
  end
end
