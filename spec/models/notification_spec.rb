# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notificationモデルのテスト', type: :model do
  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:comment).macro).to eq :belongs_to
      end
    end

    context 'Chatモデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:chat).macro).to eq :belongs_to
      end
    end

    context 'Visiter(User)モデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:visiter).macro).to eq :belongs_to
      end
    end

    context 'Visited(User)モデルとの関係' do
      it '1:Nとなっている' do
        expect(Notification.reflect_on_association(:visited).macro).to eq :belongs_to
      end
    end
  end
end
