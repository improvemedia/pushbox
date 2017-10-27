# frozen_string_literal: true

module Controllers
  module ActionPathMethodConcern
    extend ActiveSupport::Concern

    included do
      helper_method :action_path
    end

    def action_path
      path = controller_path.split("/")
      path << action_name if controller_name != action_name
      path.join("-")
    end
  end
end
