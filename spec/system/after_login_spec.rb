# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーのログイン後のテスト' do
  let(:user)        { create(:user)                   }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト： ログイン時' do
    context 'リンクの内容' do
      subject { current_path } # テスト対象の明確化

      it 'チャットを押すと、チャット一覧に遷移' do
        chat_link = find_all('a')[1].native.inner_text
        chat_link = chat_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link chat_link
        is_expected.to eq '/chats'
      end
      it 'ユーザー一覧を押すと、ユーザー一覧に遷移' do
        users_link = find_all('a')[2].native.inner_text
        users_link = users_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq '/users'
      end
      it '投稿一覧を押すと、投稿一覧に遷移' do
        posts_link = find_all('a')[3].native.inner_text
        posts_link = posts_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link posts_link
        is_expected.to eq '/posts'
      end
      it 'マイページを押すと、詳細画面に遷移' do
        mypage_link = find_all('a')[4].native.inner_text
        mypage_link = mypage_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it '通知を押すと、通知一覧へ遷移' do
        notification_link = find_all('a')[5].native.inner_text
        notification_link.delete("\n").gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link notification_link
        is_expected.to eq '/users/' + user.id.to_s + '/notifications'
      end
    end
  end
end
