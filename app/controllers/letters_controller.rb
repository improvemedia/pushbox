class LettersController < ApplicationController
  def index
    @presenter = presenter
  end

  def new
    @presenter = presenter
  end

  private

  def index_params
    {}
  end
end
