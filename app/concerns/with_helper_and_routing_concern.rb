# frozen_string_literal: true

module WithHelperAndRoutingConcern
  extend ActiveSupport::Concern

  # rubocop:disable Style/ClassVars
  module ClassMethods
    def h
      @@__h ||= ApplicationController.new.view_context
    end

    def r
      @@__r ||= begin
        Object.new.tap do |obj|
          obj.singleton_class.include(Rails.application.routes.url_helpers)
        end
      end
    end
  end
  # rubocop:enable Style/ClassVars

  def h
    @___h ||= respond_to?(:__view_context) ? __view_context : self.class.h
  end

  def r
    @___r ||= self.class.r
  end
end
