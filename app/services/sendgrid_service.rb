require 'sendgrid-ruby'

class SendgridService
  cattr_reader :sendgrid_client, instance_accessor: false do
  	SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY']).client
  end

  def self.create_contact(user)
		contacts = {
	    contacts: [{
				email: user.email,
		    first_name: user.first_name,
		    last_name: user.last_name
			}]
		}

		response = sendgrid_client.marketing.contacts.put(request_body: contacts)
	end
end