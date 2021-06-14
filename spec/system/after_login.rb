require 'rails_helper'

describe '[02] ユーザーのログイン後のテスト' do
   let(:user) { create(:user) }
   let!(:other_user) { create(:user) }
   let!(:post) { create(:post, user: user) }
   let!(:other_post) { create(:post, user: other_user) }
 
   before do
     visit new_user_session_path
     fill_in 'user[email]', with: user.email
     fill_in 'user[password]', with: user.password
     click_button 'ログイン'
   end
   
  describe 'ヘッダーのテスト： ログイン時' do
      context 'リンクの内容' do
        subject { current_path } #テスト対象の明確化
        
        it 'チャットを押すと、チャット一覧に遷移' do
          chat_link = find_all('a')[1].native.inner_text
          chat_link = chat_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link chat_link
          is_expected.to eq '/chats'
        end
        it 'ユーザー一覧を押すと、ユーザー一覧に遷移' do
          users_link = find_all('a')[2].native.inner_text
          users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link users_link
          is_expected.to eq '/users'
        end
        it '投稿一覧を押すと、投稿一覧に遷移' do
          posts_link = find_all('a')[3].native.inner_text
          posts_link = posts_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link posts_link
          is_expected.to eq '/posts'
        end
        it 'マイページを押すと、詳細画面に遷移' do
          mypage_link = find_all('a')[4].native.inner_text
          mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link mypage_link
          is_expected.to eq '/users/' + user.id.to_s
        end
        it '通知を押すと、通知一覧へ遷移' do
          notification_link = find_all('a')[5].native.inner_text
          notification_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
          click_link notification_link
          is_expected.to eq '/users/' + user.id.to_s + '/notifications'
        end
      end
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
        expect(all('img').size).to eq(3) #userとotherの二人?
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
        # expect(page).to have_field 'user[profile_image]', with: user.profile_image
        # expect(find('#user_profile_image', visible: false)).to have_field 'user[profile_image]', with: user.profile_image
        # should have_selector('#user_profile_image')
        expect(page).to attach_file 'post_image', "#{fixture_path}/image.png", visible: false # hiddenで隠れているファイル,matcheが出てくる...
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
        attach_file "user[profile_image]", "app/assets/images/abe.jpg"
        select '青森', from: 'user[prefecture_code]' #select
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
        # select '書籍', from: 'post[genre_id]'
        find("#post_genre_id").find("option[value='2']").select_option
        attach_file "post[post_image]", "app/assets/images/abe.jpg" #画像はattach
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
        expect(page).to have_field 'post[post_image]', with: post.post_image
      end
      it 'ジャンル編集フォームが表示される' do
        expect(page).to have_field 'post[genre_id]', with: post.genre
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
        find("#post_genre_id").find("option[value='2']").select_option
        attach_file "post[post_image]", "app/assets/images/abe.jpg"
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
        expect(current_path).to eq '/posts/'+ post.id.to_s
      end
    end
    
    
  end
end