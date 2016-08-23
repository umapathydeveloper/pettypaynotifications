module API  
  module V1
    class Pushnotifications < Grape::API
      include API::V1::Defaults


     helpers do
 
    end


      resource :pushnotifications do
        desc "Return all orders"
        get "", root: :pushnotifications do


gcm = GCM.new("AIzaSyAyfHA_6u0Fez7I-FkSPosrlbmuAJLpjIU")
# you can set option parameters in here
#  - all options are pass to HTTParty method arguments
#  - ref: https://github.com/jnunemaker/httparty/blob/master/lib/httparty.rb#L29-L60
#  gcm = GCM.new("my_api_key", timeout: 3)

registration_ids= ["dGAi-Dm164o:APA91bGfWa7cu_ZHLP3pN-c5DCObkez5-djntOqfjmM2qqc070Eeuyon0ODYvfkcCgDWC351voXhuCnWnlk08PiPNt1WHUdXNQzi7C43pAXFe_IRSOz9c--ulH8knEyFmKEIZbWKbqB-"] # an array of one or more client registration tokens
options = {data: {score: "123"}, collapse_key: "updated_score"}
response = gcm.send(registration_ids, options)


        end
 
      end
    end
  end
end 