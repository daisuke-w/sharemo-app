class PromptsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_prompt, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit
  before_action :prompts_by_category, only: [:show, :edit]

  def new
    @prompt = Prompt.new
  end

  def create
    @prompt = Prompt.new(prompt_params)
    if @prompt.save
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
    if @prompt.update(prompt_params)
      redirect_to note_path(@prompt)
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

  def prompt_params
    params.require(:prompt).permit(:title, :content, :category_id, :is_public).merge(user_id: current_user.id)
  end

  def find_prompt
    @prompt = Prompt.find(params[:id])
  end

  def move_to_index
    # ログインユーザーとプロンプト保有者が別人の場合は一覧ページに遷移
    redirect_to notes_path if current_user != @prompt.user
  end

  def prompts_by_category
    @prompts_by_category = current_user.prompts.group_by(&:category)
  end
end
