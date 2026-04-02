require 'rails_helper'

RSpec.describe "workouts/new", type: :view do
  before(:each) do
    assign(:workout, Workout.new(
      gym: nil,
      name: "MyString",
      warm_up: "MyText",
      skill: "MyText",
      wod: "MyText"
    ))
  end

  it "renders new workout form" do
    render

    assert_select "form[action=?][method=?]", workouts_path, "post" do
      assert_select "input[name=?]", "workout[gym_id]"

      assert_select "input[name=?]", "workout[name]"

      assert_select "textarea[name=?]", "workout[warm_up]"

      assert_select "textarea[name=?]", "workout[skill]"

      assert_select "textarea[name=?]", "workout[wod]"
    end
  end
end
