# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:post) { create(:post, user_id: user.id) }
    
    context 'titleカラム' do
      it '空欄では保存されない' do
        post.title = ''
        expect(post).not_to be_valid
      end
      it '15文字以下はOK' do
        post.title = Faker::Lorem.characters(number: 15)
        expect(post).to be_valid
      end
      it '16文字以上はNG' do
        post.title = Faker::Lorem.characters(number: 16)
        expect(post).not_to be_valid
      end
    end
    
    context 'contentカラム' do
      it '30文字以上はOK' do
        post.content = Faker::Lorem.characters(number: 30)
        expect(post).to be_valid
      end
      it '30文字以下はNG' do
        post.content = Faker::Lorem.characters(number: 29)
        expect(post).not_to be_valid
      end
    end
    
    context 'post_imageカラム' do
      it '空欄でないこと' do
        post.title = ''
        expect(post).not_to be_valid
      end
    end
    
    context 'genre_idカラム' do
      it '空欄でないこと' do
        post.title = ''
        expect(post).not_to be_valid
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
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Coomentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Notificationモデルとの関係' do
      it '1:Nとなっている' do
        expect(Post.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end