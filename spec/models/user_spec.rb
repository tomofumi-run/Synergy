require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }
    
    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }
    
    context 'last_nameカラム' do
      it '空欄でないこと' do
        user.last_name = ''
        is_expected.to eq false
      end
    end
    
    context 'first_nameカラム' do
      it '空欄でないこと' do
        user.first_name = ''
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でないこと' do 
        user.email = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        user.email = other_user.email
        is_expected.to eq false
      end
      it 'is invalid' do
        user.email = 'user@example,com'
        expect(user).to be_invalid

        user.email = 'user_at_foo.org'
        expect(user).to be_invalid

        user.email = 'user.name@example.'
        expect(user).to be_invalid

        user.email = 'foo@bar_baz.com'
        expect(user).to be_invalid

        user.email = 'foo@bar+baz.com'
        expect(user).to be_invalid
      end
    end
    
    context 'prefecture_code' do
      it '空欄でないこと' do
        user.prefecture_code = ''
        is_expected.to eq false
      end
    end
  end
end