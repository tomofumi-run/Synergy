# 非同期テストx
require 'rails_helper'

RSpec.describe "Relationships", type: :system do
before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    sign_in(@user1)
    visit users_path(@user2)    
  end
  
  describe 'フォローとアンフォロー' do
    it 'ユーザーをフォロー,アンフォローできる' do
      find('#follow-btn').click
      expect(page).to have_selector('#unfollow')
      expect(@user1.followings.count).to eq(1)
      expect(@user2.followers.count).to eq(1)
      
      find('#follow-btn').click
      expect(page).to have_selector('#follow')
      expect(@user1.followings.count).to eq(1)
      expect(@user2.followers.count).to eq(1)      
    end
  end
  
  # describe 'フォロー一覧の表示' do
  #   it '自分自身のフォロー一覧を表示できる' do
  #     click_link '/users/' + @user2.id.to_s + '/followings'
  #     expect(current_path).to have_content('フォロー一覧')
  #   end
  # end
end