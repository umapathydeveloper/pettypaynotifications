class NotificationController < ApplicationController
  	require 'gcm'
def index
gcm = GCM.new("AIzaSyCV7wF3laJAaeru-cW27S6HXA3UoawrwtI") # Server key from Step 1
registration_ids = ["dGAi-Dm164o:APA91bGfWa7cu_ZHLP3pN-c5DCObkez5-djntOqfjmM2qqc070Eeuyon0ODYvfkcCgDWC351voXhuCnWnlk08PiPNt1WHUdXNQzi7C43pAXFe_IRSOz9c--ulH8knEyFmKEIZbWKbqB-"]
gcm.send(registration_ids, {data: {message: "Hello World"}})


end

end