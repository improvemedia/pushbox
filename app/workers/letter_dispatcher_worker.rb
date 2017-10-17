# frozen_string_literal: true

class LetterDispatcherWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(letter_id)
    LetterDispatcherService.dispatch_async(letter_id: letter_id)
  end
end
