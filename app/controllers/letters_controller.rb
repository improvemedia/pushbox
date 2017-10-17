# frozen_string_literal: true

class LettersController < ApplicationController
  def index
    @presenter = presenter
  end

  def new
    @presenter = presenter
  end

  def create
    form = LetterForm.new(create_params)

    if form.save
      redirect_to action: :index, notice: "Рассылка создана"
    else
      render :new, locals: { presenter: presenter_for("new", create_params) }
    end
  end

  private

  def index_params
    {}
  end

  def create_params
    params.require(:letter).permit(:title, :start_at, :template_id).merge(letter: Letter.new)
  end
end
