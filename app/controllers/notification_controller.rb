class NotificationController < ApplicationController
	require 'httparty'
	HTTParty::Basement.default_options.update(verify: false)
	def index
		registration_ids = ["fsfeFEWNv2A:APA91bGdeqpElSvMz929f3PrFH3PJEKMFmZg-wHV0GCEVUvqp7_SqzfrxrjbSD2qiI8HjcxOhLSUzcIs7Iliy6YGG2_D5ZcY8Z6VBwsy2_aIw6X5WbC4CWq6bn7rJBeL15qGtGA06yEp", "e7o9bUgRNNg:APA91bGOSBQDUBTlQewK4vbAPpATCFXhvOOQ-RTnPE_tFyGUZjKeHqQXoTto8dwbDp09fi1tSxBJrcWbCQzstg9zba23xVNGGmadBQCUbXrzPPh93wHWdyPBimr34OLbtDeIX8oA3wg5"]
		options = {notification: {body: "Deposit 10,000 and get 2% cashback", title: "Hurray! Deposit offer", icon: "ic_camera"}}
		response = send_notification(registration_ids, options)
	end
	def send_notification(registration_ids, options = {})
		post_body = build_post_body(registration_ids, options)
		params = {body: post_body.to_json}		}
		uri = URI.parse("https://fcm.googleapis.com/fcm/send")
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json',  'Authorization' => "key=AIzaSyBRCDGmDEpQaflCvXE4g4-PZ7Fink53SWw",})
		request.body = post_body.to_json
		response = http.request(request)
		render :status => 200, :json => { :response => {"status" => "success", "message" =>   response.body}}
	end
	def build_post_body(registration_ids, options = {})
		{ registration_ids: registration_ids }.merge(options)
	end
	def build_response(response, registration_ids = [])
		body = response.body || {}
		response_hash = { body: body, headers: response.headers, status_code: response.code }
		case response.code
		when 200
			response_hash[:response] = 'success'
			body = JSON.parse(body) unless body.empty?
			response_hash[:canonical_ids] = build_canonical_ids(body, registration_ids) unless registration_ids.empty?
			response_hash[:not_registered_ids] = build_not_registered_ids(body, registration_ids) unless registration_ids.empty?
		when 400
			response_hash[:response] = 'Only applies for JSON requests. Indicates that the request could not be parsed as JSON, or it contained invalid fields.'
		when 401
			response_hash[:response] = 'There was an error authenticating the sender account.'
		when 503
			response_hash[:response] = 'Server is temporarily unavailable.'
		when 500..599
			response_hash[:response] = 'There was an internal error in the FCM server while trying to process the request.'
		end
	end
end