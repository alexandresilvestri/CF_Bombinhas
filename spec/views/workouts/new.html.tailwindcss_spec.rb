require 'rails_helper'

RSpec.describe "workouts/new", type: :view do
  before(:each) do
    assign(:workout, Workout.new(
      tenant: nil,
      name: "MyString",
      max_capacity: 1
    ))
  end

  it "renders new workout form" do
    render

    assert_select "form[action=?][method=?]", workouts_path, "post" do

      assert_select "input[name=?]", "workout[tenant_id]"

      assert_select "input[name=?]", "workout[name]"

      assert_select "input[name=?]", "workout[max_capacity]"
    end
  end
end
