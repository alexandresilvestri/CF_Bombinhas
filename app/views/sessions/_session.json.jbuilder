json.extract! session, :id, :start_time, :max_capacity, :name, :created_at, :updated_at
json.url session_url(session, format: :json)
