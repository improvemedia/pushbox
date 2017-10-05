module WithHelperAndRoutingConcern
  extend ActiveSupport::Concern

  module ClassMethods
    @@__h       = nil
    @@__r       = nil

    def h
      return @@__h if @@__h
      @@__h = ApplicationController.new.view_context
    end
    def r
      return @@__r if @@__r
      o = Object.new
      class << o
        include Rails.application.routes.url_helpers
        #include UrlHelpersExtension
      end
     @@__r = o
    end
  end

  def h
    return @___h if @___h
    view_context = respond_to?('__view_context') ? __view_context : nil
    @___h = view_context || self.class.h
  end

  def r
    @___r ||= self.class.r
  end
end
