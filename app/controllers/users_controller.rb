class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy, :basic_info, :notes_info, :prompts_info]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :basic_info, :notes_info, :prompts_info]
  before_action :init_user_info, only: [:show, :basic_info, :notes_info, :prompts_info]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :check_group_and_redirect, only: :show

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.user_image.purge
    redirect_to user_path(@user)
  end

  def basic_info
    render partial: 'shared/basic_info'
  end

  def notes_info
    render partial: 'shared/notes_info', locals: { public_notes: @public_notes, private_notes: @private_notes }
  end

  def prompts_info
    render partial: 'shared/prompts_info', locals: { public_prompts: @public_prompts, private_prompts: @private_prompts }
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :profile, :user_image, :group_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def init_user_info
    user_info_service = UserInfoService.new(@user)
    user_information = user_info_service.user_information
    @note_information = user_information[:note_information]
    @prompt_information = user_information[:prompt_information]
    @public_notes = user_information[:public_notes]
    @private_notes = user_information[:private_notes]
    @public_prompts = user_information[:public_prompts]
    @private_prompts = user_information[:private_prompts]
    @notes_by_category = user_information[:notes_by_category]
    @prompts_by_category = user_information[:prompts_by_category]
  end

  def move_to_index
    # ログインユーザーとマイページが別人の場合は一覧ページに遷移
    redirect_to notes_path if current_user.id != @user.id
  end

  def check_group_and_redirect
    # 同じグループではない場合は一覧ページに遷移
    redirect_to notes_path if current_user.group_id != @user.group_id
  end
end
