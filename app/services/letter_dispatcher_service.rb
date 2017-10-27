class LetterDispatcherService
  include Virtus.model
  extend Memoist

  attribute :letter_id, Integer

  def self.dispatch(letter_id:)
    new(letter_id: letter_id).dispatch
  end

  def dispatch
    users_for_dispatch.find_each do |user|
      SendEmailsWorker.perform_async(user_id, letter.pushbox_templates_id)
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
