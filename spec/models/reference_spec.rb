require 'rails_helper'

RSpec.describe Reference, type: :model do
  before do
    @user_note = FactoryBot.create(:user)
    @user_prompt = FactoryBot.create(:user)
    @note = FactoryBot.create(:note, user: @user_note)
    @prompt = FactoryBot.create(:prompt, user: @user_prompt)
    @reference_note = FactoryBot.build(:reference, referencable: @note)
    @reference_prompt = FactoryBot.build(:reference, referencable: @prompt)
  end
  describe '参考テーブル' do
    context 'Noteとの紐づき' do
      it '有効なReferenceであること' do
        expect(@reference_note).to be_valid
      end
      it 'referencable_typeがなければ無効であること' do
        @reference_note.referencable_type = nil
        @reference_note.valid?
        expect(@reference_note.errors.full_messages).to include("Referencable type can't be blank")
      end
      it 'referencable_idがなければ無効であること' do
        @reference_note.referencable_id = nil
        @reference_note.valid?
        expect(@reference_note.errors.full_messages).to include("Referencable can't be blank")
      end
    end
    context 'Promptとの紐づき' do
      it '有効なReferenceであること' do
        expect(@reference_prompt).to be_valid
      end
      it 'referencable_typeがなければ無効であること' do
        @reference_prompt.referencable_type = nil
        @reference_prompt.valid?
        expect(@reference_prompt.errors.full_messages).to include("Referencable type can't be blank")
      end
      it 'referencable_idがなければ無効であること' do
        @reference_prompt.referencable_id = nil
        @reference_prompt.valid?
        expect(@reference_prompt.errors.full_messages).to include("Referencable can't be blank")
      end
    end
  end
end
