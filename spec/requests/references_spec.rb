require 'rails_helper'

RSpec.describe ReferencesController, type: :request do
  before do
    @note = FactoryBot.create(:note)
    @prompt = FactoryBot.create(:prompt)
    @reference_note = FactoryBot.create(:reference, referencable: @note, click_count: 0)
    @reference_prompt = FactoryBot.create(:reference, referencable: @prompt, click_count: 0)
  end

  describe 'POST #increment_clicks' do
    context 'Noteの場合' do
      context 'アイコンが通常状態の場合' do
        it 'クリック数が増加する' do
          increment_clicks(@note, false)
          expect_click_count(@reference_note, 1)
        end
      end

      context 'アイコンが塗りつぶし状態の場合' do
        it 'クリック数が減少する' do
          @reference_note.update(click_count: 1)
          increment_clicks(@note, true)
          expect_click_count(@reference_note, 0)
        end
      end
    end

    context 'Promptの場合' do
      context 'アイコンが通常状態の場合' do
        it 'クリック数が増加する' do
          increment_clicks(@prompt, false)
          expect_click_count(@reference_prompt, 1)
        end
      end

      context 'アイコンが塗りつぶし状態の場合' do
        it 'クリック数が減少する' do
          @reference_prompt.update(click_count: 1)
          increment_clicks(@prompt, true)
          expect_click_count(@reference_prompt, 0)
        end
      end
    end
  end
end
