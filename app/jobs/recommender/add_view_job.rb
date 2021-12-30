class Recommender::AddViewJob < ApplicationJob
  queue_as :default

  def perform(user, item, recomm_id = nil)
    interactions = [RecommenderService.add_view(user, item, recomm_id)]
    RecommenderService.send_batch(interactions)
  end
end