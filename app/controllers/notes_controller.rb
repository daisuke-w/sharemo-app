class NotesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_note, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :notes_by_category, only: [:show, :edit]

  def index
    @notes = Note.includes(:user, :prompt, :tags, :reference).order(created_at: :desc)
    @prompts = Prompt.includes(:user, :notes, :tags, :reference).order(created_at: :desc)
    @objects = (@notes + @prompts).sort_by(&:created_at).reverse
  end

  def new
    @note_form = NoteForm.new
    @prompt = Prompt.find(params[:prompt_id]) if params[:prompt_id]
  end

  def create
    @note_form = NoteForm.new(note_form_params)
    @note_form.prompt_id = params[:prompt_id] if params[:prompt_id]
    if @note_form.valid?
      @note_form.save
      redirect_to notes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # 非公開ノートには所有者以外アクセスできないようにする
    redirect_to notes_path if !@note.is_public && (current_user.nil? || current_user != @note.user)
  end

  def edit
    note_attributes = @note.attributes
    @prompt = Prompt.find(note_attributes['prompt_id']) if note_attributes['prompt_id']
    @note_form = NoteForm.new(note_attributes)
    @note_form.tag_name = @note.tags.pluck(:tag_name).join(',')
  end

  def update
    @note_form = NoteForm.new(note_form_params)
    if @note_form.valid?
      @note_form.update(note_form_params, @note)
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

  def note_form_params
    note_form = params.require(:note_form)
    note_form_permitted = [:title, :content, :category_id, :is_public, :tag_name, :color_code]
    note_form_permitted << :prompt_id if note_form[:prompt_id]
    permitted_params = note_form.permit(note_form_permitted).merge(user_id: current_user.id)

    # 末尾のカンマと空白を除去する
    permitted_params[:tag_name] = permitted_params[:tag_name].chomp(', ')
    permitted_params
  end

  def find_note
    @note = Note.find(params[:id])
  end

  def move_to_index
    # ログインユーザーとノート保有者が別人の場合は一覧ページに遷移
    redirect_to notes_path if current_user != @note.user
  end

  def notes_by_category
    @notes_by_category = current_user&.notes&.group_by(&:category)
  end
end
