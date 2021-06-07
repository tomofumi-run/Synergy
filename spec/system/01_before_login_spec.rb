require 'rails_helper'

describe '[01] ユーザーのログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    
    context '表示内容の確認' do
      it 'urlが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインが表示される: 左上から4番目のリンクが「ログイン」である。' do
        log_in_link = find_all('a')[4].native.innner_text
        expect(log_in_link).to match(/ログイン/i)
      end
      it 'ログインのリンク内容が正しい' do
        log_in_link = find_all('a')[4].native.innner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it '新規登録が表示される: 左上から3番目のリンクが「新規登録」である。' do
        sign_up_link = find_all('a')[3].native.innner_text
        expect(sign_up_link).to match(/新規登録/i)
      end
      it '新規登録のリンク内容が正しい' do
        sign_up_link = find_all('a')[3].native.innner_text
        expect(page).to have_link sign_up_link, href: new_registration_path
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
      it 'サイトについてが表示される: 左上から2番目のリンクが「サイトについて」である。' do
        about_link = find_all('a')[2].native.innner_text
        expect(about_link).to match(/サイトについて/i)
      end
      it '新規登録が表示される: 左上から3番目のリンクが「新規登録」である。' do
        sign_up_link = find_all('a')[3].native.innner_text
        expect(sign_up_link).to match(/新規登録/i)
      end
      it 'ログインが表示される: 左上から4番目のリンクが「ログイン」である。' do
        log_in_link = find_all('a')[4].native.innner_text
        expect(log_in_link).to match(/ログイン/i)
      end
    end
    
    context 'リンクの内容を確認' do
      subject { current_path }
      
      it 'サイトについてを押すと、サイト詳細画面に遷移する' do
        about_link = find_all('a')[2].native.innner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq '/about'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        sign_up_link = find_all('a')[3].native.innner_text
        sign_up_link = sign_up_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link sign_up_link
        is_expected.to eq '/users/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        log_in_link = find_all('a')[4].native.innner_text
        log_in_link = log_in_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link log_in_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end
end