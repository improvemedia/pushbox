class LetterDispatcherWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(letter_id)
    LetterDispatcherService.dispatch(letter_id: letter_id)
  end
end
