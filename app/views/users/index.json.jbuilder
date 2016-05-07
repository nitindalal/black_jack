json.array!(@users) do |user|
  json.extract! user, :id, :role_cd, :name
  json.url user_url(user, format: :json)
end
