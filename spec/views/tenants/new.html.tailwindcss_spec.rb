require 'rails_helper'

RSpec.describe "tenants/new", type: :view do
  before(:each) do
    assign(:tenant, Tenant.new(
      stripe_customer_id: 1,
      name: "MyString",
      corporate_name: "MyString",
      cnpj: "MyString",
      address: "MyString",
      representative_name: "MyString",
      representative_cpf: "MyString"
    ))
  end

  it "renders new tenant form" do
    render

    assert_select "form[action=?][method=?]", tenants_path, "post" do
      assert_select "input[name=?]", "tenant[stripe_customer_id]"

      assert_select "input[name=?]", "tenant[name]"

      assert_select "input[name=?]", "tenant[corporate_name]"

      assert_select "input[name=?]", "tenant[cnpj]"

      assert_select "input[name=?]", "tenant[address]"

      assert_select "input[name=?]", "tenant[representative_name]"

      assert_select "input[name=?]", "tenant[representative_cpf]"
    end
  end
end
