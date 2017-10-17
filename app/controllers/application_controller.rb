# frozen_string_literal: true

class ApplicationController < ActionController::Base
  extend Memoist

  protect_from_forgery with: :exception

  include Controllers::ActionPathMethodConcern
  include Controllers::PresenterMethodConcern

  helper_method :layout_entity

  def layout_entity
    @presenter.try(:application_layout_entity) || ApplicationPresenter.new.application_layout_entity
  end
  memoize :layout_entity
end
