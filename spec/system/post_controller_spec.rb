# frozen_string_literal: true

require 'rails_helper'

describe 'Postコントローラーのテスト' do
  let(:user)        { create(:user)                                        }
  let!(:other_user) { create(:user)                                        }
  let!(:post)       { create(:post, user: user, genre: genre)              }
  let!(:other_post) { create(:post, user: other_user, genre: other_genre)  }
  let!(:genre)      { create(:genre)                                       }
  let!(:other_genre){ create(:genre)                                       }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  
describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it '他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: post_path(other_post)
      end
      it '他人の投稿のタイトルが表示される' do
        expect(page).to have_content other_post.title
      end
    end

    context '投稿成功のテスト' do
      before do
        visit new_post_path
        find('#post_genre_id').find("option[value='1']").select_option
        attach_file 'post[post_image]', 'app/assets/images/follow.jpg' # 画像はattach
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 10)
        fill_in 'post[content]', with: Faker::Lorem.characters(number: 30)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.posts, :count).by(1)
      end
      it 'リダレクト先が保存できた投稿の詳細画面' do
        click_button '投稿'
        expect(current_path).to eq '/posts/' + Post.last.id.to_s
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it '「投稿編集」と表示される' do
        expect(page).to have_content '投稿編集'
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'post[post_image]'
      end
      it 'ジャンル編集フォームが表示される' do
        expect(page).to have_field 'post[genre_id]', with: post.genre_id
      end
      it 'タイトル編集フォームが表示される' do
        expect(page).to have_field 'post[title]', with: post.title
      end
      it '内容編集フォームが表示される' do
        expect(page).to have_field 'post[content]', with: post.content
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
    end

    context '編集成功のテスト' do
      before do
        @post_old_image = post.post_image
        @post_old_genre = post.genre
        @post_old_title = post.title
        @post_old_content = post.content
        # select '書籍', from: 'post[genre_id]'
        find('#post_genre_id').find("option[value='2']").select_option
        attach_file 'post[post_image]', 'app/assets/images/follow.jpg'
        fill_in 'post[title]', with: Faker::Lorem.characters(number: 8)
        fill_in 'post[content]', with: Faker::Lorem.characters(number: 40)
        click_button '更新する'
      end

      it 'ジャンルが正しく更新される' do
        expect(post.reload.genre).not_to eq @post_old_genre
      end
      it '画像が正しく更新される' do
        expect(post.reload.post_image).not_to eq @post_old_image
      end
      it 'タイトルが正しく更新される' do
        expect(post.reload.title).not_to eq @post_old_title
      end
      it '内容が正しく更新される' do
        expect(post.reload.content).not_to eq @post_old_content
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
    end
  end
end