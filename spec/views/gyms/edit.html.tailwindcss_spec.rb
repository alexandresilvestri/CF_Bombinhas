require 'rails_helper'

RSpec.describe "gyms/edit", type: :view do
  let(:gym) {
    Gym.create!(
      name: "MyString",
      corporate_name: "MyString",
      subdomain: "my-string"
    )
  }

  before(:each) do
    assign(:gym, gym)
  end

  it "renders the edit gym form" do
    render

    assert_select "form[action=?][method=?]", gym_path(gym), "post" do
      assert_select "input[name=?]", "gym[name]"

      assert_select "input[name=?]", "gym[corporate_name]"

      assert_select "input[name=?]", "gym[subdomain]"
    end
  end
end
