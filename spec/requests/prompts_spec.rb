require 'rails_helper'

RSpec.describe PromptsController, type: :request do
  before do
    @user_prompt = FactoryBot.create(:user)
    @prompt = FactoryBot.create(:prompt, user: @user_prompt)
    @public_prompt = FactoryBot.create(:prompt, user: @user_prompt, is_public: true)
    @private_prompt = FactoryBot.create(:prompt, user: @user_prompt, is_public: false)
  end

  describe 'GET #new' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, new_prompt_path)
      end
    end

    context '認証されている場合' do
      before { sign_in @user_prompt }

      it '正常にレスポンスが返ってくる' do
        expect_successful_response(:get, new_prompt_path)
      end
    end
  end

  describe 'GET #show' do
    context '認証されていない場合' do
      it '公開プロンプトにアクセスできる' do
        expect_successful_response(:get, prompt_path(@public_prompt))
      end
      it '非公開プロンプトにはアクセスできない' do
        expect_redirect_to_list(:get, prompt_path(@private_prompt))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_prompt }

      context '公開プロンプトの場合' do
        it 'プロンプトが表示される' do
          expect_successful_response(:get, prompt_path(@public_prompt))
          expect_element_in_response(:get, prompt_path(@public_prompt), @public_prompt.title)
        end
      end

      context '非公開プロンプトを所有している場合' do
        it 'プロンプトが表示される' do
          expect_successful_response(:get, prompt_path(@private_prompt))
          expect_element_in_response(:get, prompt_path(@private_prompt), @private_prompt.title)
        end
      end

      context '非公開プロンプトの所有者が別人の場合' do
        other_user = FactoryBot.create(:user)
        other_private_prompt = FactoryBot.create(:prompt, user: other_user, is_public: false)

        it '一覧ページにリダイレクトされる' do
          expect_redirect_to_list(:get, prompt_path(other_private_prompt))
        end
      end
    end
  end

  describe 'POST #create' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:post, prompts_path)
      end
    end

    context '認証されている場合' do
      before { sign_in @user_prompt }

      context '有効なパラメータを送信した場合' do
        it 'プロンプトを作成し、ノート一覧ページにリダイレクトされる' do
          expect do
            post prompts_path, params: {
              prompt_form: {
                category_id: 2,
                is_public: 0,
                title: '新しいプロンプト',
                content: '内容',
                tag_name: 'tag1'
              }
            }
          end.to change(Prompt, :count).by(1)
          expect(response).to redirect_to(notes_path)
        end
      end

      context '無効なパラメータを送信した場合' do
        it '新規作成ページを再表示する' do
          post prompts_path, params: { prompt_form: { title: '', content: '' } }
          expect(response.body).to include('markdown-area')
        end
      end
    end
  end

  describe 'GET #edit' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, edit_prompt_path(@prompt))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_prompt }

      it '正常にレスポンスが返ってくる' do
        expect_successful_response(:get, edit_prompt_path(@prompt))
      end
    end
  end

  describe 'PATCH #update' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:patch, prompt_path(@prompt))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_prompt }

      context '有効なパラメータを送信した場合' do
        it 'プロンプトを更新し、プロンプト詳細ページにリダイレクトされる' do
          patch prompt_path(@prompt), params: {
            prompt_form: {
              category_id: @prompt.category_id,
              is_public: @prompt.is_public,
              title: '更新されたプロンプト',
              content: @prompt.content,
              tag_name: @prompt.tags
            }
          }
          expect(@prompt.reload.title).to eq '更新されたプロンプト'
          expect(response).to redirect_to(prompt_path(@prompt))
        end
      end

      context '無効なパラメータを送信した場合' do
        it '編集ページを再表示する' do
          patch prompt_path(@prompt), params: {
            prompt_form: {
              category_id: @prompt.category_id,
              is_public: @prompt.is_public,
              title: '',
              content: @prompt.content,
              tag_name: @prompt.tags
            }
          }
          expect(response.body).to include('markdown-area')
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:delete, prompt_path(@prompt))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_prompt }

      it 'プロンプトを削除し、ノート一覧ページにリダイレクトされる' do
        expect do
          delete prompt_path(@prompt)
        end.to change(Prompt, :count).by(-1)
        expect(response).to redirect_to(notes_path)
      end

      it '他のユーザーのプロンプトを削除できない' do
        other_user = FactoryBot.create(:user)
        other_prompt = FactoryBot.create(:prompt, user: other_user)

        expect do
          delete prompt_path(other_prompt)
        end.to change(Prompt, :count).by(0)
        expect(response).to redirect_to(notes_path)
      end
    end
  end
end
