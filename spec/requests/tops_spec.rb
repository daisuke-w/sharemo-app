require 'rails_helper'

RSpec.describe TopsController, type: :request do
  describe 'GET #index' do
    context '認証されていない場合' do
      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        expect_successful_response(:get, root_path)
      end
      it 'indexアクションにリクエストするとレスポンスにTopページのテキストが存在する' do
        expect_element_in_response(:get, root_path, 'SHAREMOでMemoを')
      end
      it 'indexアクションにリクエストするとレスポンスにTopページのGifが存在する' do
        expect_element_in_response(:get, root_path, 'Example GIF')
      end
      it 'indexアクションにリクエストするとレスポンスにヘッダーが存在する' do
        expect_element_in_response(:get, root_path, 'header')
      end
      it 'indexアクションにリクエストするとレスポンスにフッターが存在する' do
        expect_element_in_response(:get, root_path, 'footer')
      end
    end

    context '認証されている場合' do
      before { sign_in FactoryBot.create(:user) }

      it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do
        expect_successful_response(:get, root_path)
      end
      it 'indexアクションにリクエストするとレスポンスにTopページのテキストが存在する' do
        expect_element_in_response(:get, root_path, 'SHAREMOでMemoを')
      end
      it 'indexアクションにリクエストするとレスポンスにTopページのGifが存在する' do
        expect_element_in_response(:get, root_path, 'Example GIF')
      end
      it 'indexアクションにリクエストするとレスポンスにヘッダーが存在する' do
        expect_element_in_response(:get, root_path, 'header')
      end
      it 'indexアクションにリクエストするとレスポンスにフッターが存在する' do
        expect_element_in_response(:get, root_path, 'footer')
      end
    end
  end
end
