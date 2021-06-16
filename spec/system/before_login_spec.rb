# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーのログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインが表示される: ナビバー左上から3番目のリンクが「ログイン」である。' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(log_in_link).to match(/ログイン/i)
      end
      it 'ログインのリンク内容が正しい' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it '新規登録が表示される: ナビバー左上から2番目のリンクが「新規登録」である。' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(sign_up_link).to match(/新規登録/i)
      end
      it '新規登録のリンク内容が正しい' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit '/about'
    end

    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログイン前' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'サイトについてが表示される: ナビバー左上から1番目のリンクが「サイトについて」である。' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/サイトについて/i)
      end
      it '新規登録が表示される: ナビバー左上から2番目のリンクが「新規登録」である。' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(sign_up_link).to match(/新規登録/i)
      end
      it 'ログインが表示される: ナビバー左上から3番目のリンクが「ログイン」である。' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(log_in_link).to match(/ログイン/i)
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'サイトについてを押すと、サイト詳細画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        sign_up_link = find_all('a')[2].native.inner_text
        sign_up_link = sign_up_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link sign_up_link
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        log_in_link = find_all('a')[3].native.inner_text
        log_in_link = log_in_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link log_in_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザー新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規会員登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it '苗字入力フォームが表示される' do
        expect(page).to have_field 'user[last_name]'
      end
      it '名前入力フォームが表示される' do
        expect(page).to have_field 'user[first_name]'
      end
      it '学校所在地入力フォームが表示される' do
        expect(page).to have_field 'user[prefecture_code]'
      end
      it '教員歴入力フォームが表示される' do
        expect(page).to have_field 'user[history_status]'
      end
      it 'メールアドレス入力フォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワード入力フォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'パスワード確認入力フォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it '会員登録ボタンが表示される' do
        expect(page).to have_button '会員登録'
      end
    end

    describe '会員登録成功のテスト' do
      before do
        fill_in 'user[last_name]', with: '星野'
        fill_in 'user[first_name]', with: '結衣'
        select '北海道', from: 'user[prefecture_code]' # select
        select '2年目', from: 'user[history_status]'
        fill_in 'user[email]', with: 'hoshinoyui@nigehaji.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
      end

      it '正しく会員登録される' do
        expect { click_button '会員登録' }.to change(User.all, :count).by(1)
      end
      it '会員登録後のページが投稿一覧ページになっている' do
        click_button '会員登録'
        expect(current_path).to eq '/posts'
      end
    end
  end

  describe 'ユーザーのログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'メールアドレス入力フォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'パスワード入力フォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のページが投稿一覧ページになっている' do
        expect(current_path).to eq '/posts'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト： ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示確認' do
      it 'navの1番目が「チャット」' do
        chat_link = find_all('a')[1].native.inner_text
        expect(chat_link).to match('チャット')
      end
      it 'navの2番目が「ユーザー一覧」' do
        users_link = find_all('a')[2].native.inner_text
        expect(users_link).to match('ユーザー一覧')
      end
      it 'navの3番目が「投稿一覧」' do
        posts_link = find_all('a')[3].native.inner_text
        expect(posts_link).to match('投稿一覧')
      end
      it 'navの4番目が「マイページ」' do
        mypage_link = find_all('a')[4].native.inner_text
        expect(mypage_link).to match('マイページ')
      end
      it 'navの5番目が「通知」' do
        notification_link = find_all('a')[5].native.inner_text
        expect(notification_link).to match('通知')
      end
      it 'navの6番目が「ログアウト」' do
        logout_link = find_all('a')[6].native.inner_text
        expect(logout_link).to match('ログアウト')
      end
    end
  end

  describe 'ユーザーログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[6].native.inner_text
      logout_link = logout_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウト出来ている： ログアウト後に「サイトについて」のリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
