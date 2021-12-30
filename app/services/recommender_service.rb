require 'recombee_api_client'

class RecommenderService
	include RecombeeApiClient

	COLUMN_TYPE = {
		string: 'string',
		enum: 'string',
		integer: 'int',
		float: 'double',
		boolean: 'boolean',
		datetime: 'timestamp'
	}

  cattr_reader :recombee_client, instance_accessor: false do
    RecombeeApiClient::RecombeeClient.new(ENV['RECOMBEE_DB_ID'], ENV['RECOMBEE_PRIVATE_TOKEN'])
  end

  def self.send_batch(items)
  	recombee_client.send(Batch.new(items))
  rescue RecombeeApiClient::ResponseError => error
  	p error
  end

  # 📦 ITEMS
  def self.add_item(item)
  	AddItem.new(item.recombee_id)
  end

  def self.delete_item(item)
  	DeleteItem.new(item.recombee_id)
  end

  def self.add_item_property(property_name, type)
  	AddItemProperty.new(property_name, type)
  end

  def self.set_item_values(item, values)
  	SetItemValues.new(item.recombee_id, values, { cascade_create: true })
  end

  # 😄 USERS
  def self.add_user(user)
  	AddUser.new(user.id)
  end

  # ✋ INTERACTIONS
  def self.add_view(user, item, recomm_id = nil)
    options = recomm_id ? { recomm_id: recomm_id, cascade_create: true } : { cascade_create: true }
  	AddDetailView.new(user.recombee_id, item.recombee_id, { cascade_create: true })
  end

  def self.add_purchase(user, item)
  	AddPurchase.new(user.recombee_id, item.recombee_id, { cascade_create: true })
  end

  def self.add_bookmark(user, item, recomm_id = nil)
    options = recomm_id ? { recomm_id: recomm_id, cascade_create: true } : { cascade_create: true }
	  AddBookmark.new(user.recombee_id, item.recombee_id, options)
  end

  def self.delete_bookmark(user, item, recomm_id = nil)
    options = recomm_id ? { recomm_id: recomm_id } : {}
    DeleteBookmark.new(user.recombee_id, item.recombee_id, options)
  end

  def self.add_view_portion(user, item, portion, session_id, recomm_id = nil)
  	if recomm_id
  		SetViewPortion.new(user.recombee_id, item.recombee_id, portion, { cascade_create: true, session_id: session_id, recomm_id: recomm_id })
  	else
  		AddBookmark.new(user.recombee_id, item.recombee_id, portion, { cascade_create: true, session_id: session_id })
  	end
  end
end