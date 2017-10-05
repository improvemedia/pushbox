class ProfilesController < ApplicationController
  def show
    @presenter = ProfilesShowPresenter.new(show_params)
  end


  private


  def show_params
    {}
  end

end
