require 'rails_helper'

RSpec.describe "tenants/index", type: :view do
  before(:each) do
    assign(:tenants, [
      Tenant.create!(
        stripe_customer_id: 2,
        name: "Name",
        corporate_name: "Corporate Name",
        cnpj: "Cnpj",
        address: "Address",
        representative_name: "Representative Name",
        representative_cpf: "Representative Cpf"
      ),
      Tenant.create!(
        stripe_customer_id: 2,
        name: "Name",
        corporate_name: "Corporate Name",
        cnpj: "Cnpj",
        address: "Address",
        representative_name: "Representative Name",
        representative_cpf: "Representative Cpf"
      )
    ])
  end

  it "renders a list of tenants" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Corporate Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Cnpj".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Address".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Representative Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Representative Cpf".to_s), count: 2
  end
end
