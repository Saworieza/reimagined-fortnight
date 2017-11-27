json.array!(@users) do |user|
  json.extract! user, :id, :name, :username, :password,  :about, :location, :website, :avatar
  json.url user_url(user, format: :json)
end
