require 'recombee_api_client'

class RecommenderService
	include RecombeeApiClient

  cattr_reader :recombee_client, instance_accessor: false do
    RecombeeClient(ENV['RECOMBEE_DB_ID'], ENV['RECOMBEE_PRIVATE_TOKEN'])
  end

  def self.add_item(item)
  	recombee_client.send(AddItem.new(item.recombee_id))
  end

  def self.add_item(property_name, type)
  	recombee_client.send(AddItemProperty.new(property_name, type))
  end

  def self.report_view(user, item)
  	recombee_client.send(AddDetailView.new(user.recombee_id, item.recombee_id, {cascade_create: true}))
  end

  def self.report_purchase(user, item)
  	recombee_client.send(AddPurchase.new(user.recombee_id, item.recombee_id, {cascade_create: true}))
  end

  def self.report_bookmark(user, item, recomm_id = nil)
  	if recomm_id
  		recombee_client.send(AddBookmark.new(user.recombee_id, item.recombee_id, {cascade_create: true, recomm_id: recomm_id}))
  	else
  		recombee_client.send(AddBookmark.new(user.recombee_id, item.recombee_id, {cascade_create: true}))
  	end
  end

  def self.report_view_portion(user, item, portion, session_id, recomm_id = nil)
  	if recomm_id
  		recombee_client.send(SetViewPortion.new(user.recombee_id, item.recombee_id, portion, {cascade_create: true, session_id: session_id, recomm_id: recomm_id}))
  	else
  		recombee_client.send(AddBookmark.new(user.recombee_id, item.recombee_id, portion, {cascade_create: true, session_id: session_id}))
  	end
  end
end