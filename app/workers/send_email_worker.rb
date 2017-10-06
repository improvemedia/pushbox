class SendEmailWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(user_data, template_id)
    EmailDeliveryService.deliver(user_data: user_data, template_id: template_id)
  end
end
