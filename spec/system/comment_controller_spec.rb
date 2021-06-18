require 'rails_helper'

RSpec.describe "Comments", type: :system do
    let(:user)        { create(:user)                   }
    let(:post)       { create(:post, user: user)       }
    let!(:comment)    { create(:comment, user: user, post: post )}
    
    before do
      sign_in(user)
      visit post_path(post.id)
    end
    
    describe 'コメント投稿、削除' do
      context '表示内容の確認' do
        it 'コメントフォームが表示される' do
          expect(page).to have_selector('#comment_comment')
          expect(page).to have_css('.btn-outline-success')
        end
      end
      context 'コメントの投稿削除機能の確認' do
        it '投稿に対して、コメントとコメント削除ができる', js: true do
          fill_in 'comment[comment]', with: comment.comment
          find('#comment_comment').click
          expect(comment.comment.count).to eq(1)
          
          find('.btn-outline-danger').click
          expect(comment.comment.count).to eq(0)
        end
      end
    end
 end