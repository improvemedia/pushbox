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

  def create
    form = TemplateForm.new(create_params)

    if form.save
      redirect_to action: :index, notice: 'Шаблон создан'
    else
      render :new, locals: { presenter: presenter_for('new', create_params) }
    end
  end

  def update
    form = TemplateForm.new(update_params)
    if form.save
      redirect_to template_path(form.template), notice: 'Успешно'
    else
      render :edit, locals: { presenter: presenter_for('edit', update_params) }
    end
  end

  private

  def template
    Template.find(params[:id])
  end
  memoize :template

  def show_params
    {}
  end

  def create_params
    params.require(:template).permit(:title, :body).merge(template: Template.new)
  end

  def update_params
    params.require(:template).permit(:title, :body).merge(template: template)
  end

  def new_params
    {}
  end

  def edit_params
    {}
  end
end
