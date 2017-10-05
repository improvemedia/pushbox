class Admin::ChatroomsController < Admin::ApplicationController
  def index
    @presenter = presenter
  end

  def link
  end

  private


  def index_params
    {}
  end


end
