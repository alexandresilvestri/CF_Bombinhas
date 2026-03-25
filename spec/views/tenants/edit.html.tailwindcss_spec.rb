require 'rails_helper'

RSpec.describe "tenants/edit", type: :view do
  let(:tenant) {
    Tenant.create!(
      stripe_customer_id: 1,
      name: "MyString",
      corporate_name: "MyString",
      cnpj: "MyString",
      address: "MyString",
      representative_name: "MyString",
      representative_cpf: "MyString"
    )
  }

  before(:each) do
    assign(:tenant, tenant)
  end

  it "renders the edit tenant form" do
    render

    assert_select "form[action=?][method=?]", tenant_path(tenant), "post" do
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
