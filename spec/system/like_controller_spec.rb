# 非同期テストx
require 'rails_helper'

RSpec.describe "Likes", type: :system do
    let(:user)        { create(:user)                   }
    let(:post)       { create(:post, user: user)       }
    
    before do
      sign_in(user)
      visit post_path(post.id)
    end
    
    describe 'お気に入り登録、解除' do
      it 'ユーザーが他の投稿のお気に入り登録と解除ができる' do
        find('#like_btn').click
        expect(page).to have_selector '.fas fa-star'
        expect(post.likes.count).to eq(1)
        
        find('#like_btn').click
        expect(page).to have_selector 'far fa-star'
        expect(post.likes.count).to eq(0)
      end
    end
 end