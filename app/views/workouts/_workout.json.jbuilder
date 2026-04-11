json.extract! workout, :id, :name, :warm_up, :skill, :wod, :created_at, :updated_at
json.url workout_url(workout, format: :json)
