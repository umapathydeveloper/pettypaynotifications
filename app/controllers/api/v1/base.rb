module API  
  module V1
    class Base < Grape::API
   		require 'gcm'
      mount API::V1::Pushnotifications
      # mount API::V1::AnotherResource
    end
  end
end  