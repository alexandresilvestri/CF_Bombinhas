require 'rails_helper'

RSpec.describe "workouts/show", type: :view do
  before(:each) do
    gym = Gym.create!(name: "Test Gym")
    assign(:workout, Workout.create!(
      gym: gym,
      name: "Name",
      warm_up: "MyText",
      skill: "MyText",
      wod: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
  end
end
