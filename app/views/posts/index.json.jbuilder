json.posts @posts do |post|
  json.title post.title
  json.short_text post.text.truncate(50, separator: ' ')
  json.text post.text
  json.photo_url request.host_with_port() + post.photo.url(:original)
end