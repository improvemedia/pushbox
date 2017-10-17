# frozen_string_literal: true

class LetterDispatcherService
  include Virtus.model
  extend Memoist

  attribute :letter_id, Integer

  def self.dispatch_async(letter_id:)
    new(letter_id: letter_id).dispatch_async
  end

  def dispatch_async
    users_for_dispatch.find_each do |user|
      user_data = user.attributes.slice("email", "first_name").compact
      SendEmailWorker.perform_async(user_data, letter.pushbox_templates_id)
    end
  end

  private

  def letter
    LetterRepository.find(letter_id)
  end
  memoize :letter

  def users_for_dispatch
    UserRepository.for_segment(letter.segment)
  end
  memoize :users_for_dispatch
end
