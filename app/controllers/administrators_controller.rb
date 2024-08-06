class AdministratorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:update_owner, :destroy_user]

  def index
    @users = User.all
  end

  def update_owner
    # 変更対象のユーザーID
    new_owner_id = params[:new_owner_id]

    ActiveRecord::Base.transaction do
      @user.notes.update_all(user_id: new_owner_id)
      @user.prompts.update_all(user_id: new_owner_id)
    end

    render json: { status: 'success' }
  rescue StandardError => e
    render json: { status: 'error', message: e.message }, status: :unprocessable_entity
  end

  def destroy_user
    ActiveRecord::Base.transaction do
      # ユーザーが所有するノートに関連するデータを削除
      @user.notes.each do |note|
        # NoteTag と Reference を削除
        note.note_tags.destroy_all
        note.reference.destroy if note.reference.present?
      end

      # ユーザーが所有するプロンプトに関連するデータを削除
      @user.prompts.each do |prompt|
        # PromptTag と Reference を削除
        prompt.prompt_tags.destroy_all
        prompt.reference.destroy if prompt.reference.present?
      end

      # ノートとプロンプトを削除
      @user.notes.destroy_all
      @user.prompts.destroy_all

      # ユーザーを削除
      @user.destroy
    end

    redirect_to administrators_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
