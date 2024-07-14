require 'rails_helper'

RSpec.describe SearchesController, type: :request do
  describe 'GET #tags' do
    context '検索キーワードが指定されている場合' do
      it '対応するタグをJSON形式で返すこと' do
        # テスト用のタグデータを準備
        Tag.create(tag_name: 'test1', color_code: 1)
        keyword = 't'

        expect_successful_response(:get, tags_searches_path, params: { keyword: })
        expect(JSON.parse(response.body)['keyword'].map { |tag| tag['tag_name'] }).to include('test1')
      end
    end

    context '検索キーワードが指定されていない場合' do
      it '空の結果を返すこと' do
        expect_successful_response(:get, tags_searches_path)
        expect(JSON.parse(response.body)['keyword']).to be_empty
      end
    end
  end

  describe 'GET #results' do
    before do
      @user = FactoryBot.create(:user)
      @note1 = FactoryBot.create(:note, user: @user, is_public: true)
      @note2 = FactoryBot.create(:note, user: @user, is_public: true)
      @prompt1 = FactoryBot.create(:prompt, user: @user, is_public: true)
      @prompt2 = FactoryBot.create(:prompt, user: @user, is_public: true)
      @tag = FactoryBot.create(:tag)
      NoteTag.create(tag_id: @tag.id, note_id: @note1.id)
    end

    context '検索キーワードが指定されている場合' do
      it '対応するノートを返すこと' do
        expect_successful_response(:get, results_searches_path, params: { keyword: @note1.title })
        expect_element_in_response(:get, results_searches_path, @note1.title)
      end

      it '対応するプロンプトを返すこと' do
        expect_successful_response(:get, results_searches_path, params: { keyword: @prompt1.title })
        expect_element_in_response(:get, results_searches_path, @prompt1.title)
      end
    end

    context '検索カテゴリーが指定されている場合' do
      it '対応するノート or プロンプトを返すこと' do
        expect_successful_response(:get, results_searches_path, params: { category: @note2.category_id })
        expect_element_in_response(:get, results_searches_path, @note2.title)
      end
    end

    context '検索タグが指定されている場合' do
      it '対応するノート or プロンプトを返すこと' do
        expect_successful_response(:get, results_searches_path, params: { tags: @tag.id })
        expect_element_in_response(:get, results_searches_path, @note1.title)
      end
    end

    context '検索タイプにNoteが指定されている場合' do
      it '対応するノートを返すこと' do
        expect_successful_response(:get, results_searches_path, params: { type: 'Note' })
        expect_element_in_response(:get, results_searches_path, @note1.title)
      end
    end

    context '検索タイプにPromptが指定されている場合' do
      it '対応するプロンプトを返すこと' do
        expect_successful_response(:get, results_searches_path, params: { type: 'Prompt' })
        expect_element_in_response(:get, results_searches_path, @prompt1.title)
      end
    end
  end
end
