json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :body, :tweet_id, :user_id
  json.url tweet_url(tweet, format: :json)
end
