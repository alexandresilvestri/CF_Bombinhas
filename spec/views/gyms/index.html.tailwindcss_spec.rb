require 'rails_helper'

RSpec.describe "gyms/index", type: :view do
  before(:each) do
    assign(:gyms, [
      Gym.create!(
        name: "Name",
        corporate_name: "Corporate Name",
        subdomain: "gym-one"
      ),
      Gym.create!(
        name: "Name",
        corporate_name: "Corporate Name",
        subdomain: "gym-two"
      )
    ])
  end

  it "renders a list of gyms" do
    render
    cell_selector = 'div[id^="gym_"]'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Corporate Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("gym-one".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("gym-two".to_s), count: 1
  end
end
