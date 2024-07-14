require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end
  describe 'Tag作成' do
    context '新規作成できる場合' do
      it '入力項目がすべて存在すれば作成できる' do
        expect(@tag).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'tag_nameが空の場合Tagは作成されないが処理は有効である' do
        @tag.tag_name = ''
        expect(@tag).to be_valid
      end
      it '重複したtag_nameが存在する場合は作成できない' do
        @tag.save
        another_user = FactoryBot.build(:tag, tag_name: @tag.tag_name)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Tag name has already been taken')
      end
      it 'color_codeが空では作成できない' do
        @tag.color_code = ''
        @tag.valid?
        expect(@tag.errors.full_messages).to include("Color code can't be blank")
      end
      it 'color_codeが1未満では作成できない' do
        @tag.color_code = 0
        @tag.valid?
        expect(@tag.errors.full_messages).to include('Color code must be greater than or equal to 1')
      end
      it 'color_codeが10より大きいと作成できない' do
        @tag.color_code = 11
        @tag.valid?
        expect(@tag.errors.full_messages).to include('Color code must be less than or equal to 10')
      end
    end
  end
end
