# frozen_string_literal: true

module MailingRepository
  module_function

  delegate :find, to: :model_class

  def for_send
    model_class.all
  end

  private

  def model_class
    Mailing
  end
end
