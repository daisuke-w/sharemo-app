class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_note, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @notes = Note.includes(:user, :prompt)
    @prompts = Prompt.includes(:user)
    @objects = (@notes + @prompts)
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
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to note_path(@note)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # ログインユーザーとノート保有者が別人の場合はなにもしない
    return if current_user != @note.user

    @note.destroy
    redirect_to notes_path
  end

  private

  def note_params
    permitted_params = params.require(:note).permit(:title, :content, :category_id, :is_public).merge(user_id: current_user.id)
    # prompt_idのマージ nullを許容
    permitted_params = permitted_params.merge(prompt_id: params[:prompt_id]) if params[:prompt_id]
    permitted_params
  end

  def find_note
    @note = Note.find(params[:id])
  end

  def move_to_index
    # ログインユーザーとノート保有者が別人の場合は一覧ページに遷移
    redirect_to notes_path if current_user != @note.user
  end
end
