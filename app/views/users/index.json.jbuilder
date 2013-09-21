json.array!(@users) do |user|
  json.extract! user, :phone, :first_name, :last_name
  json.url user_url(user, format: :json)
end
