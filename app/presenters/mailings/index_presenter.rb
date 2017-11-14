# frozen_string_literal: true

module Mailings
  class IndexPresenter < ApplicationPresenter
    class MailingEntity < BaseEntity
      attribute :id
      attribute :title
      attribute :segment_title
      attribute :dispatch_at
      attribute :template_title
      attribute :destroy_url
    end

    def mailing_entities
      mailings.map do |mailing|
        MailingEntity.new(
          id:             mailing.id,
          title:          mailing.title,
          segment_title:  mailing.segment&.title || "Все пользователи",
          dispatch_at:    mailing.dispatch_at,
          template_title: mailing.template.title,
          destroy_url:    r.mailing_path(mailing.id)
        )
      end
    end

    private

    def mailings
      Mailing.includes(:segment, :template)
    end

    def active_page_side_nav_item
      :mailings
    end
  end
end
