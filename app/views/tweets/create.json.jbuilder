json.tweets @tweets do |tweet|
  json.id tweet.id
  json.username tweet.user.username
  json.message tweet.message
end
