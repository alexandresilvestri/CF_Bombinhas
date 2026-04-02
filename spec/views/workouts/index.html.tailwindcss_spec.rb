require 'rails_helper'

RSpec.describe "workouts/index", type: :view do
  before(:each) do
    gym = Gym.create!(name: "Test Gym")
    assign(:workouts, [
      Workout.create!(
        gym: gym,
        name: "Name",
        warm_up: "MyText",
        skill: "MyText",
        wod: "MyText"
      ),
      Workout.create!(
        gym: gym,
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
