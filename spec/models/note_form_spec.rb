require 'rails_helper'

RSpec.describe NoteForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    prompt_form = FactoryBot.build(:prompt_form, user_id: user.id)
    @note_form = FactoryBot.build(:note_form, user_id: user.id, prompt_id: prompt_form.id)
    @tag = FactoryBot.build(:tag)
  end
  describe 'Note作成' do
    context '新規作成できる場合' do
      it '入力項目がすべて存在すれば作成できる' do
        @note_form.tag_name = @tag.tag_name
        @note_form.color_code = @tag.color_code
        expect(@note_form).to be_valid
      end
      it 'tag_nameが空の場合Tagは作成されないがNoteは作成される' do
        @note_form.tag_name = ''
        @note_form.color_code = ''
        expect(@note_form).to be_valid
      end
      it 'prompt_idが空の場合でも作成される' do
        @note_form.prompt_id = nil
        expect(@note_form).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'category_idが1では作成できない' do
        @note_form.category_id = 1
        @note_form.valid?
        expect(@note_form.errors.full_messages).to include("Category can't be blank")
      end
      it 'titleが空では作成できない' do
        @note_form.title = ''
        @note_form.valid?
        expect(@note_form.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空では作成できない' do
        @note_form.content = ''
        @note_form.valid?
        expect(@note_form.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが紐付いていないと作成できない' do
        @note_form.user_id = nil
        @note_form.valid?
        expect(@note_form.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
