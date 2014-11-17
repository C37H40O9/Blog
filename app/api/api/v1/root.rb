# lib/api/v1/root.rb
module API
  module V1
    class Root < Grape::API
      mount API::V1::Posts
      error_formatter :json, API::V1::ErrorFormatter
    end
  end
end
