# lib/api/v1/posts.rb
require 'grape'

module API
  module V1
    class Posts < Grape::API
      version 'v1'
      format :json

      resource :posts do
        desc "Return list of recent posts"
        get do
          Post.all.map{ |p| {title: p.title, short_text: p.text.slice(0,20), text: p.text, photo_url: request.host_with_port() + p.photo.url(:original)} }
        end
      end
    end
  end
end
