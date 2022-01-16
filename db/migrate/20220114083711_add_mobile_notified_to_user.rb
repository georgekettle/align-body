class AddMobileNotifiedToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :upgrade_sms_sent, :boolean, null: false, default: false
  end
end
