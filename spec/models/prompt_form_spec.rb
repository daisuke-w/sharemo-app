require 'rails_helper'

RSpec.describe PromptForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    @prompt_form = FactoryBot.build(:prompt_form, user_id: user.id)
    @tag = FactoryBot.build(:tag)
  end
  describe 'Prompt作成' do
    context '新規作成できる場合' do
      it '入力項目がすべて存在すれば作成できる' do
        @prompt_form.tag_name = @tag.tag_name
        @prompt_form.color_code = @tag.color_code
        expect(@prompt_form).to be_valid
      end
      it 'tag_nameが空の場合Tagは作成されないがPromptは作成される' do
        @prompt_form.tag_name = ''
        @prompt_form.color_code = ''
        expect(@prompt_form).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'category_idが1では作成できない' do
        @prompt_form.category_id = 1
        @prompt_form.valid?
        expect(@prompt_form.errors.full_messages).to include("Category can't be blank")
      end
      it 'titleが空では作成できない' do
        @prompt_form.title = ''
        @prompt_form.valid?
        expect(@prompt_form.errors.full_messages).to include("Title can't be blank")
      end
      it 'contentが空では作成できない' do
        @prompt_form.content = ''
        @prompt_form.valid?
        expect(@prompt_form.errors.full_messages).to include("Content can't be blank")
      end
      it 'userが紐付いていないと作成できない' do
        @prompt_form.user_id = nil
        @prompt_form.valid?
        expect(@prompt_form.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
