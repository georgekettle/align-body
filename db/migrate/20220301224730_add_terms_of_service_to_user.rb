class AddTermsOfServiceToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :terms_of_service, :boolean, null: false, default: false
  end
end
