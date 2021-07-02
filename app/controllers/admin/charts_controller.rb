class Admin::ChartsController < ApplicationController
 before_action :authenticate_admin!
 
 def post_chart
    posts = Post.all
    @two_days_ago_book = posts.where(created_at: 7.days.ago.all_day).count
    # @three_days_ago_book = posts.where(created_at: 3.days.ago.all_day).count
    # @four_days_ago_book = posts.where(created_at: 4.days.ago.all_day).count
    # @five_days_ago_book = posts.where(created_at: 5.days.ago.all_day).count
    # @six_days_ago_book = posts.where(created_at: 6.days.ago.all_day).count
 end
 
 def user_chart
    users = User.all
    @two_days_ago_book = users.where(created_at: 7.days.ago.all_day).count
    # @three_days_ago_book = users.where(created_at: 3.days.ago.all_day).count
    # @four_days_ago_book = users.where(created_at: 4.days.ago.all_day).count
    # @five_days_ago_book = users.where(created_at: 5.days.ago.all_day).count
    # @six_days_ago_book = users.where(created_at: 6.days.ago.all_day).count
 end
 
end
