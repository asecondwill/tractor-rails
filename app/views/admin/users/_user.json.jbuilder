json.extract! user, :id, :name, :email, :admin, :staff, :created_at, :updated_at
json.url user_url(user, format: :json)
