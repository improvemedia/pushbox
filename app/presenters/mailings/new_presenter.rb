# frozen_string_literal: true

module Mailings
  class NewPresenter < ApplicationPresenter
    attribute :mailing, Mailing, default: proc { Mailing.new }

    attribute :title,       String
    attribute :template_id, Integer
    attribute :segment_id,  Integer
    attribute :start_at,    Time

    def mailing_form
      MailingForm.new(mailing: mailing)
    end
  end
end
