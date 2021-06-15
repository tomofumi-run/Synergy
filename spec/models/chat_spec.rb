# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chatモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user)                                     }
    let(:room) { create(:room)                                     }
    let(:chat) { build(:chat, user_id: user.id, room_id: room.id)  }

    context '保存できない場合' do
      it '空欄では送信できない' do
        chat.talk = ''
        expect(chat).not_to be_valid
      end
      it '141字以上は送信できない' do
        chat.talk = Faker::Lorem.characters(number: 141)
        expect(chat).not_to be_valid
      end
    end

    context '保存できる場合' do
      it '140字以内は送信できる' do
        chat.talk = Faker::Lorem.characters(number: 140)
        expect(chat).to be_valid
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Chat.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Roomモデルとの関係' do
      it 'N:1となっている' do
        expect(Chat.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
  end
end
