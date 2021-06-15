require 'rails_helper'

RSpec.describe 'Likeモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }
    
    let(:user) { create(:user) }
    let(:post) { build(:post, user_id: user.id) }
    let(:like) { create(:like, user_id: user.id, post_id: post.id)}
    
    context 'お気に入り' do
      it '一意性があること' do
        user.likes = user.likes
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Like.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Postモデルとの関係' do
      it 'N:1となっている' do
        expect(Like.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end