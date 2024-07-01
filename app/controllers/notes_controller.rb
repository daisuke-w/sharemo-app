class NotesController < ApplicationController

  def index
    @notes = Note.includes(:user, :prompt)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to notes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  private

  def note_params
    permitted_params = params.require(:note).permit(:title, :content, :category_id).merge(user_id: current_user.id)
    # prompt_idのマージ nullを許容
    permitted_params = permitted_params.merge(prompt_id: params[:prompt_id]) if params[:prompt_id]
    permitted_params
  end
end
