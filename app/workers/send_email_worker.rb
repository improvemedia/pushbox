class SendEmailWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(user_id, template_id)
    EmailDeliveryService.deliver(user_id: user_id, template_id: template_id)
  end
end
