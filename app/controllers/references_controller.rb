class ReferencesController < ApplicationController
  before_action :find_referenceable

  def increment_clicks
    @reference = Reference.find_by(referencable_type: @type, referencable_id: @id)
    is_filled = ActiveModel::Type::Boolean.new.cast(params[:is_filled])
    if is_filled
      # アイコンが塗りつぶし状態の場合、クリック数を減らす
      @reference.decrement!(:click_count)
    else
      # アイコンが通常状態の場合、クリック数を増やす
      @reference.increment!(:click_count)
    end
    render json: { click_count: @reference.click_count }
  end

  private

  def find_referenceable
    if params[:note_id]
      @referenceable = Note.find(params[:note_id])
      @type = 'Note'
      @id = params[:note_id]
    elsif params[:prompt_id]
      @referenceable = Prompt.find(params[:prompt_id])
      @type = 'Prompt'
      @id = params[:prompt_id]
    end
  end
end
