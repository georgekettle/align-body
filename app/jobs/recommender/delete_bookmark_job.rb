class Recommender::DeleteBookmarkJob < ApplicationJob
  queue_as :default

  def perform(user, item, recomm_id = nil)
    interactions = [RecommenderService.delete_bookmark(user, item, recomm_id)]
    RecommenderService.send_batch(interactions)
  end
end