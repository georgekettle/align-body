class CreateSendgridContactJob < ApplicationJob
  queue_as :default

  def perform(user)
    SendgridService.create_contact(user)
  end
end
