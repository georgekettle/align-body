require 'twilio-ruby'

class SmsService
  cattr_reader :sms_client, instance_accessor: false do
  	Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def self.send_message(target_number, content, callback=nil)
  	if callback
	  	message = sms_client.messages.create(
															from: ENV['TWILIO_NUMBER'],
															to: target_number,
															body: content,
															status_callback: callback,
														)
  	else
  		message = sms_client.messages.create(
															from: ENV['TWILIO_NUMBER'],
															to: target_number,
															body: content
														)
  	end
  	
	end
end