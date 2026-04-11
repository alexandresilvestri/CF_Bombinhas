require 'rails_helper'

RSpec.describe "workouts/index", type: :view do
  before(:each) do
    assign(:workouts, [
      Workout.create!(
        name: "Name",
        warm_up: "MyText",
        skill: "MyText",
        wod: "MyText"
      ),
      Workout.create!(
        name: "Name",
        warm_up: "MyText",
        skill: "MyText",
        wod: "MyText"
      )
    ])
  end

  it "renders a list of workouts" do
    render
    expect(rendered).to include(nil.to_s)
    expect(rendered).to include("Name".to_s)
    expect(rendered).to include("MyText".to_s)
    expect(rendered).to include("MyText".to_s)
    expect(rendered).to include("MyText".to_s)
  end
end
