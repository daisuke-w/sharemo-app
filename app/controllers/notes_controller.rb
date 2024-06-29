class NotesController < ApplicationController

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to root_path # TODO 他の画面作成次第変更
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def note_params
    permitted_params = params.require(:note).permit(:title, :content, :category_id).merge(user_id: current_user.id)
    # prompt_idのマージ nullを許容
    permitted_params = permitted_params.merge(prompt_id: params[:prompt_id]) if params[:prompt_id]
    permitted_params
  end
end