class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def recombee_id
    self.class.to_s.downcase + '_' + id.to_s
  end
end
