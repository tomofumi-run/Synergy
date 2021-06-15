require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post.valid? }
    
    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }
    
    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        is_expected.to eq false
      end
      it '15文字以下であること: 15文字はx' do
        post.title = Faker::Lorem.characters(number: 15)
        is_expected.to eq false

      end
    end
    
    context 'contentカラム' do
      it '空欄でないこと' do
        post.content = ''
        is_expected.to eq false
      end
      it '30文字以上であること: 30文字はx' do
        post.content = Faker::Lorem.characters(number: 30)
        is_expected.to eq false
      end
    end
    
    context 'post_imageカラム' do
      it '空欄でないこと' do
        post.post_image = ''
        is_expected.to eq false
      end
    end
    
    context 'genre_idカラム' do
      it '空欄でないこと' do
        post.genre = nil
        is_expected.to eq false
      end
    end
  end
  
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:genre).macro).to eq :belongs_to
      end
    end
    context 'Likeモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Coomentモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end