# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user)        { build(:user)  }

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
      it '正規表記でしか登録できないこと' do
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

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

    context 'Relationshipモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
    end

    context 'UserRoomモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end

    context 'Chatモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:chats).macro).to eq :has_many
      end
    end

    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
end
