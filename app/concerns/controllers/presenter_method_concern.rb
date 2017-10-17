# frozen_string_literal: true

module Controllers
  module PresenterMethodConcern
    extend ActiveSupport::Concern

    def presenter(custom_params = nil)
      presenter_for(action_name, custom_params)
    end

    def presenter_for(action_name, custom_params = nil)
      @presenter ||= PresenterResolver.build(
        action_name:     action_name,
        controller_name: controller_name,
        class_name:      self.class.name,
        local_params:    custom_params || action_params(action_name)
      )
    end

    private

    def action_params(action_name)
      method_name = "#{action_name}_params"
      return unless respond_to?(method_name)
      send(method_name)
    end

    class PresenterResolver
      include Virtus.model

      PRESENTER_CLASS_ACTION_MAPPING = {
        edit:   "form",
        new:    "form",
        update: "form",
        create: "form"
      }.freeze

      attribute :action_name
      attribute :controller_name
      attribute :class_name

      def self.build(options = {})
        local_params = options.delete(:local_params)
        new(options).presenter.new(local_params)
      end

      def presenter
        presenter_class_name.constantize
      rescue NameError => e
        raise if e.missing_name != presenter_class_name

        "Admin::Application::#{mapped_action_name.camelize}Presenter".constantize
      end

      private

      # check override
      def mapped_action_name
        action_name
      end

      def presenter_class_name
        {
          single_action_controller: "#{class_name.deconstantize}::" \
                                    "#{controller_name.camelize}Presenter",

          default:                  "#{class_name.deconstantize}::" \
                                    "#{controller_name.camelize}::" \
                                    "#{mapped_action_name.camelize}Presenter"
        }.fetch(strategy)
      end

      def strategy
        controller_name == action_name ? :single_action_controller : :default
      end
    end
  end
end
