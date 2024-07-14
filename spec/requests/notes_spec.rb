require 'rails_helper'

RSpec.describe NotesController, type: :request do
  before do
    @user_note = FactoryBot.create(:user)
    @user_prompt = FactoryBot.create(:user)
    @prompt = FactoryBot.create(:prompt, user: @user_prompt)
    @note = FactoryBot.create(:note, user: @user_note, prompt_id: @prompt.id)
    @public_note = FactoryBot.create(:note, user: @user_note, prompt: @prompt, is_public: true)
    @private_note = FactoryBot.create(:note, user: @user_note, prompt: @prompt, is_public: false)
  end

  describe 'GET #index' do
    context '認証されていない場合' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        expect_successful_response(:get, notes_path)
      end
      it 'indexアクションにリクエストするとレスポンスに検索フォームが存在する' do
        expect_element_in_response(:get, notes_path, 'search-filter-section')
      end
      it 'indexアクションにリクエストするとレスポンスにノートのtitleが存在する' do
        expect_element_in_response(:get, notes_path, 'title')
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        expect_successful_response(:get, notes_path)
      end
      it 'indexアクションにリクエストするとレスポンスに検索フォームが存在する' do
        expect_element_in_response(:get, notes_path, 'search-filter-section')
      end
      it 'indexアクションにリクエストするとレスポンスにノートのtitleが存在する' do
        expect_element_in_response(:get, notes_path, 'title')
      end
    end
  end

  describe 'GET #show' do
    context '認証されていない場合' do
      it '公開ノートにアクセスできる' do
        expect_successful_response(:get, note_path(@public_note))
      end
      it '非公開ノートにはアクセスできない' do
        expect_redirect_to_list(:get, note_path(@private_note))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      context '公開ノートの場合' do
        it 'ノートが表示される' do
          expect_successful_response(:get, note_path(@public_note))
          expect_element_in_response(:get, note_path(@public_note), @public_note.title)
        end
      end

      context '非公開ノートを所有している場合' do
        it 'ノートが表示される' do
          expect_successful_response(:get, note_path(@private_note))
          expect_element_in_response(:get, note_path(@private_note), @private_note.title)
        end
      end

      context '非公開ノートの所有者が別人の場合' do
        other_user = FactoryBot.create(:user)
        other_private_note = FactoryBot.create(:note, user: other_user, prompt: @prompt, is_public: false)

        it '一覧ページにリダイレクトされる' do
          expect_redirect_to_list(:get, note_path(other_private_note))
        end
      end
    end
  end

  describe 'GET #new' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, new_note_path)
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      it '正常にレスポンスが返ってくる' do
        expect_successful_response(:get, new_note_path)
      end

      it 'prompt_idが存在する場合、URLにprompt_idが正しく設定される' do
        get new_note_path(prompt_id: @prompt.id)
        expect(request.fullpath).to include(@prompt.id.to_s)
      end

      it 'prompt_idが存在しない場合、URLにpromptsは含まれない' do
        get new_note_path
        expect(request.fullpath).not_to include('prompts')
      end
    end
  end

  describe 'POST #create' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:post, notes_path)
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      context '有効なパラメータを送信した場合' do
        it 'ノートを作成し、ノート一覧ページにリダイレクトされる' do
          expect do
            post notes_path, params: {
              note_form: {
                category_id: 2,
                is_public: 0,
                title: '新しいノート',
                content: '内容',
                prompt_id: @prompt.id,
                tag_name: 'tag1'
              }
            }
          end.to change(Note, :count).by(1)
          expect(response).to redirect_to(notes_path)
        end
      end

      context '無効なパラメータを送信した場合' do
        it '新規作成ページを再表示する' do
          post notes_path, params: { note_form: { title: '', content: '' } }
          expect(response.body).to include('markdown-area')
        end
      end
    end
  end

  describe 'GET #edit' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:get, edit_note_path(@note))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      it '正常にレスポンスが返ってくる' do
        expect_successful_response(:get, edit_note_path(@note))
      end
    end
  end

  describe 'PATCH #update' do
    context '認証されていない場合' do
      it 'ログインページにリダイレクトされる' do
        expect_redirect_to_login(:patch, note_path(@note))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      context '有効なパラメータを送信した場合' do
        it 'ノートを更新し、ノート詳細ページにリダイレクトされる' do
          patch note_path(@note), params: {
            note_form: {
              category_id: @note.category_id,
              is_public: @note.is_public,
              title: '更新されたノート',
              content: @note.content,
              prompt_id: @note.prompt.id,
              tag_name: @note.tags
            }
          }
          expect(@note.reload.title).to eq '更新されたノート'
          expect(response).to redirect_to(note_path(@note))
        end
      end

      context '無効なパラメータを送信した場合' do
        it '編集ページを再表示する' do
          patch note_path(@note), params: {
            note_form: {
              category_id: @note.category_id,
              is_public: @note.is_public,
              title: '',
              content: @note.content,
              prompt_id: @note.prompt.id,
              tag_name: @note.tags
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
        expect_redirect_to_login(:delete, note_path(@note))
      end
    end

    context '認証されている場合' do
      before { sign_in @user_note }

      it 'ノートを削除し、ノート一覧ページにリダイレクトされる' do
        expect do
          delete note_path(@note)
        end.to change(Note, :count).by(-1)
        expect(response).to redirect_to(notes_path)
      end

      it '他のユーザーのノートを削除できない' do
        other_user = FactoryBot.create(:user)
        other_note = FactoryBot.create(:note, user: other_user, prompt: @prompt)

        expect do
          delete note_path(other_note)
        end.to change(Note, :count).by(0)
        expect(response).to redirect_to(notes_path)
      end
    end
  end
end
