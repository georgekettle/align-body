Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = "Align Fitness"
  config.business_address = "12 Japonica Heights, Halls Head WA 6210"
  config.application_name = "Align Fitness"
  config.support_email = "lyonse997@gmail.com"

  config.send_emails = true

  config.default_product_name = "default"
  config.default_plan_name = "default"

  config.automount_routes = true
  config.routes_path = "/pay" # Only when automount_routes is true
end