require 'rails_helper'

RSpec.describe 'Relationshipモデルのテスト', type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }
  describe 'フォロー可能のテスト' do
    # context '保存できる場合' do
    #   it 'パラメーターが揃っていれば保存可能' do
    #     expect(relationship).to be_valid
    #   end
    # end
    
    # context '一意性のテスト' do
    #   before do
    #     @relation = FactoryBot.create(:relationship)
    #     @user = FactoryBot.build(:relationship)
    #   end
    #   it 'follower_idとfollowed_idの組み合わせが一意でなければ保存できない' do
    #     relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @relation.followed_id)
    #     expect(relation2).to be_valid
    #   end
    #   it 'follower_idが同じでも、followed_idが違うなら保存可能' do
    #     relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @user.followed_id)
    #     expect(relation2).to be_valid
    #   end
    # end
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