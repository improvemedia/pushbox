class TemplatesController < ApplicationController
  def index
    @presenter = presenter
  end

  def new
    @presenter = presenter
  end

  def edit
    @presenter = presenter
  end

  private

  def template
    Template.find(params[:id])
  end
  memoize :template

  def show_params
    {}
  end

  def new_params
    {}
  end

  def edit_params
    {}
  end
end
