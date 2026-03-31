require 'rails_helper'

RSpec.describe "gyms/show", type: :view do
  before(:each) do
    assign(:gym, Gym.create!(
      name: "Name",
      corporate_name: "Corporate Name",
      subdomain: "my-gym"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Corporate Name/)
    expect(rendered).to match(/my-gym/)
  end
end
