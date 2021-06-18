# frozen_string_literal: true

require 'rails_helper'

describe 'Users', type: :system do
  let(:user)        { create(:user)                   }
  let!(:other_user) { create(:user)                   }
  let!(:post)       { create(:post, user: user)       }
  let(:other_post) { create(:post, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end
  describe 'ユーザー一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '他人の画像が表示される: 一覧で表示されるのは2人' do
        expect(all('img').size).to eq(3) # userとotherの二人?
      end
      it '自分と他人の名前と教員歴が表示される' do
        expect(page).to have_content user.last_name
        expect(page).to have_content user.first_name
        expect(page).to have_content user.history_status
        expect(page).to have_content other_user.last_name
        expect(page).to have_content other_user.first_name
        expect(page).to have_content other_user.history_status
      end
      it '他人の詳細リンクが表示される' do
        expect(page).to have_link '', href: user_path(other_user)
      end
    end
  end

  describe '自分のユーザー詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧に自分の投稿が表示され、リンクが正しい' do
        expect(page).to have_link '', href: post_path(post)
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: post_path(other_post)
        expect(page).not_to have_content other_post.title
      end
    end
  end

  describe '自分のユーザー情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[last_name]', with: user.last_name
        expect(page).to have_field 'user[first_name]', with: user.first_name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
        # noimageかどうか
        # expect(find('#user_profile_image', visible: false)).to have_field 'user[profile_image]', with: user.profile_image
        # should have_selector('#user_profile_image')
        # expect(page).to attach_file 'post_image', "#{fixture_path}/image.png", visible: false # hiddenで隠れているファイル,matcheが出てくる...
      end
      it '学校所在地フォームが表示される' do
        expect(page).to have_field 'user[prefecture_code]', with: user.prefecture_code
      end
      it '教員歴フォームが表示される' do
        expect(page).to have_field 'user[history_status]', with: user.history_status
      end
      it '自己紹介編集フォームが表示される' do
        expect(page).to have_field 'user[introduction]'
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_ln = user.last_name
        @user_old_fn = user.first_name
        @user_old_image = user.profile_image
        @user_old_prf = user.prefecture_code
        @user_old_history = user.history_status
        fill_in 'user[last_name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[first_name]', with: Faker::Lorem.characters(number: 5)
        attach_file 'user[profile_image]', 'app/assets/images/abe.jpg'
        select '青森', from: 'user[prefecture_code]' # select
        select '4年目', from: 'user[history_status]'
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 30)
        click_button '更新する'
      end

      it '名前が正しく更新されている' do
        expect(user.reload.last_name).not_to eq @user_old_ln
        expect(user.reload.first_name).not_to eq @user_old_fn
      end
      it 'プロフィール画像が正しく更新されている' do
        expect(user.reload.profile_image).not_to eq @user_old_image
      end
      it '学校所在地が正しく更新されている' do
        expect(user.reload.prefecture_code).not_to eq @user_old_prf
      end
      it '教員歴が正しく更新されている' do
        expect(user.reload.history_status).not_to eq @user_old_history
      end
      it 'リダイレクト先が自分のユーザー詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end