require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
  end

  describe 'GET #show' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, user_path(@user))
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it 'ユーザーの詳細ページが表示される' do
        expect_successful_response(:get, user_path(@user))
        expect_element_in_response(:get, user_path(@user), @user.nickname)
      end
    end
  end

  describe 'GET #edit' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, edit_user_path(@user))
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it 'ユーザーの編集ページが表示される' do
        expect_successful_response(:get, edit_user_path(@user))
      end
    end
  end

  describe 'PATCH #update' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        patch user_path(@user), params: { user: { nickname: 'NewNickname' } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it 'ユーザー情報が正常に更新される' do
        patch user_path(@user), params: { user: { nickname: 'NewNickname' } }
        expect(@user.reload.nickname).to eq('NewNickname')
        expect(response).to redirect_to(user_path(@user))
      end

      it '更新に失敗した場合、編集ページが再表示される' do
        patch user_path(@user), params: { user: { email: nil } }
        expect(response.body).to include('Edit Account')
      end
    end
  end

  describe 'DELETE #destroy' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:delete, user_path(@user))
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it 'ユーザー画像が削除される' do
        @user.user_image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.jpg')
        delete user_path(@user)
        expect(@user.reload.user_image.attached?).to be_falsey
        expect(response).to redirect_to(user_path(@user))
      end
    end
  end

  describe 'GET #basic_info' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, basic_info_user_path(@user))
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it '基本情報の部分が正しく表示される' do
        expect_successful_response(:get, basic_info_user_path(@user))
        expect_element_in_response(:get, basic_info_user_path(@user), 'basic-info-section')
      end
    end
  end

  describe 'GET #notes_info' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, notes_info_user_path(@user))
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it 'ノート情報の部分が正しく表示される' do
        expect_successful_response(:get, notes_info_user_path(@user))
        expect_element_in_response(:get, notes_info_user_path(@user), 'note-info-section')
      end
    end
  end

  describe 'GET #prompts_info' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, prompts_info_user_path(@user))
      end
    end

    context '認証されている場合' do
      before { sign_in @user }

      it 'プロンプト情報の部分が正しく表示される' do
        expect_successful_response(:get, prompts_info_user_path(@user))
        expect_element_in_response(:get, prompts_info_user_path(@user), 'prompt-info-section')
      end
    end
  end

  describe 'GET #init_user_info' do
    context '認証されている場合' do
      before { sign_in @user }

      it 'ユーザー情報が正しく初期化される' do
        expect_element_in_response(:get, user_path(@user), @user.nickname)
      end
    end
  end
end
