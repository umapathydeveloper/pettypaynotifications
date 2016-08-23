class NotificationsController < ApplicationController
  def create
    if !Rpush::Gcm::App.find_by_name("pettypay-partner-staging")
      app = Rpush::Gcm::App.new
      app.name = "pettypay-partner-staging"
      app.auth_key = "AIzaSyCV7wF3laJAaeru-cW27S6HXA3UoawrwtI"
      app.connections = 1
      app.save!
    end

    n = Rpush::Gcm::Notification.new
    n.app = Rpush::Gcm::App.find_by_name("pettypay-partner-staging")
    n.registration_ids = ["dGAi-Dm164o:APA91bGfWa7cu_ZHLP3pN-c5DCObkez5-djntOqfjmM2qqc070Eeuyon0ODYvfkcCgDWC351voXhuCnWnlk08PiPNt1WHUdXNQzi7C43pAXFe_IRSOz9c--ulH8knEyFmKEIZbWKbqB-"]
    message = Time.new.to_s
    n.data = { message: message }
    n.save!
  end
end