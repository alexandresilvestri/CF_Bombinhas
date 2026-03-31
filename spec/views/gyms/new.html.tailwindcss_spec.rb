require 'rails_helper'

RSpec.describe "gyms/new", type: :view do
  before(:each) do
    assign(:gym, Gym.new(
      name: "MyString",
      corporate_name: "MyString",
      subdomain: "my-string"
    ))
  end

  it "renders new gym form" do
    render

    assert_select "form[action=?][method=?]", gyms_path, "post" do
      assert_select "input[name=?]", "gym[name]"

      assert_select "input[name=?]", "gym[corporate_name]"

      assert_select "input[name=?]", "gym[subdomain]"
    end
  end
end
