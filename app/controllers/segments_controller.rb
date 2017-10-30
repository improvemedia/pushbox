class SegmentsController < ApplicationController
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
    form = SegmentForm.new(create_params)

    if form.save
      redirect_to segments_path, notice: "Шаблон создан"
    else
      render :new, locals: { presenter: presenter_for(:new, create_params) }
    end
  end

  def update
    form = SegmentForm.new(update_params)
    if form.save
      redirect_to segment_path(form.segment), notice: t("common.success")
    else
      render :edit, locals: { presenter: presenter_for(:edit, update_params) }
    end
  end

  def destroy
    segment.mark_as_deleted

    render json: { flash: { notice: 'Успешно удалено' } }
  end

  private

  def segment
    Segment.find(params[:id])
  end
  memoize :segment

  def show_params
    {}
  end

  def create_params
    form_params.merge(segment: Segment.new)
  end

  def update_params
    form_params.merge(segment: segment)
  end

  def new_params
    {}
  end

  def edit_params
    { segment: segment }
  end

  def form_params
    params.require(:segment).permit(:title, :user_ids)
  end
end
