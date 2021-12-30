module Recommendable
  extend ActiveSupport::Concern

  included do
  	after_create :add_item
  	after_destroy :delete_item
  	after_update :update_item

	  def add_item
	  	details = id == 1 ? update_recommender_columns : []
			details << RecommenderService.add_item(self)
			details << RecommenderService.set_item_values(self, self.attributes.except('id'))
			RecommenderService.send_batch(details)
	  end

	  def delete_item
			items = [ RecommenderService.delete_item(self) ]
			RecommenderService.send_batch(items)
	  end

	  def update_item
	  	items = [ RecommenderService.set_item_values(self, self.attributes.except('id')) ]
			RecommenderService.send_batch(items)
	  end

	  def update_recommender_columns
	  	columns = []
	  	attributes = self.class.columns.reject{ |col| ['id'].include?(col.name) }
	  	attributes.each do |attr|
				property_name = attr.name
	  		is_enum = self.class.defined_enums.has_key?(attr.name)
	  		metadata_type = is_enum ? :enum : attr.sql_type_metadata.type
				type = RecommenderService::COLUMN_TYPE[metadata_type]
				columns << RecommenderService.add_item_property(property_name, type)
			end
			columns
	  end
  end
end