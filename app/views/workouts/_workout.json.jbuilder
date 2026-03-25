json.extract! workout, :id, :tenant_id, :name, :start_time, :max_capacity, :created_at, :updated_at
json.url workout_url(workout, format: :json)
