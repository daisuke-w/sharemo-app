class PromptsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_prompt, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :prompts_by_category, only: [:show, :edit]

  def new
    @prompt_form = PromptForm.new
  end

  def create
    @prompt_form = PromptForm.new(prompt_form_params)
    if @prompt_form.valid?
      @prompt_form.save
      redirect_to notes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # 非公開プロンプトには所有者以外アクセスできないようにする
    redirect_to notes_path if !@prompt.is_public && (current_user.nil? || current_user != @prompt.user)
    # Noteが紐づいている場合は取得
    @notes = @prompt.notes if @prompt.present?
  end

  def edit
    prompt_attributes = @prompt.attributes
    @prompt_form = PromptForm.new(prompt_attributes)
    @prompt_form.tag_name = @prompt.tags.pluck(:tag_name).join(',')
  end

  def update
    @prompt_form = PromptForm.new(prompt_form_params)
    if @prompt_form.valid?
      @prompt_form.update(prompt_form_params, @prompt)
      redirect_to prompt_path(@prompt)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # ログインユーザーとプロンプト保有者が別人の場合はなにもしない
    return if current_user != @prompt.user

    @prompt.destroy
    redirect_to notes_path
  end

  private

  def prompt_form_params
    permitted_params = params.require(:prompt_form)
                             .permit(:title, :content, :category_id, :is_public, :tag_name, :color_code)
                             .merge(user_id: current_user.id)
    # 末尾のカンマと空白を除去する
    permitted_params[:tag_name] = permitted_params[:tag_name].chomp(', ')
    permitted_params
  end

  def find_prompt
    @prompt = Prompt.find(params[:id])
  end

  def move_to_index
    # ログインユーザーとプロンプト保有者が別人の場合は一覧ページに遷移
    redirect_to notes_path if current_user != @prompt.user
  end

  def prompts_by_category
    @prompts_by_category = current_user&.prompts&.group_by(&:category)
  end
end
