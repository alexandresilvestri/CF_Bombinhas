json.extract! tenant, :id, :stripe_customer_id, :name, :corporate_name, :cnpj, :address, :representative_name, :representative_cpf, :created_at, :updated_at
json.url tenant_url(tenant, format: :json)
