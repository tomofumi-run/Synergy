# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }

  describe 'フォロー可能のテスト' do
    context '保存できる場合' do
      it 'パラメーターが揃っていれば保存可能' do
        expect(relationship).to be_valid
      end
    end

    context '保存できない場合' do
      it 'follower_idがnilの場合は保存できない' do
        relationship.follower_id = nil
        relationship.valid?
        expect(relationship.errors[:follower_id]).to include('を入力してください')
      end

      it 'followed_idがnilの場合は保存できない' do
        relationship.followed_id = nil
        relationship.valid?
        expect(relationship.errors[:followed_id]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:follower).macro).to eq :belongs_to
      end
      it 'N:1となっている' do
        expect(Relationship.reflect_on_association(:followed).macro).to eq :belongs_to
      end
    end
  end
end
