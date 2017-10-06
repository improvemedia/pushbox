class SendEmailsWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(user_id, template_id)
    
  end
end
