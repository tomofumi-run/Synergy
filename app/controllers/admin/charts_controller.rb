class Admin::ChartsController < ApplicationController
 before_action :authenticate_admin!
 
 #userとpostに移動させる
 
 def post_chart
    posts = Post.all
    @today_post = posts.where(created_at: Date.today.all_day).count
    @yesterday_post = posts.where(created_at: 1.days.ago.all_day).count
    @two_days_ago_post = posts.where(created_at: 2.days.ago.all_day).count
    @three_days_ago_post = posts.where(created_at: 3.days.ago.all_day).count
    @four_days_ago_post = posts.where(created_at: 4.days.ago.all_day).count
    @five_days_ago_post = posts.where(created_at: 5.days.ago.all_day).count
    @six_days_ago_post = posts.where(created_at: 6.days.ago.all_day).count
    @one_week_ago_post = posts.chart_data(7)
 end
 
 def user_chart
    users = User.all
    # @two_days_ago_book = users.where(created_at: 2.days.ago.all_day).count
    # @three_days_ago_book = users.where(created_at: 3.days.ago.all_day).count
    # @four_days_ago_book = users.where(created_at: 4.days.ago.all_day).count
    # @five_days_ago_book = users.where(created_at: 5.days.ago.all_day).count
    # @six_days_ago_book = users.where(created_at: 6.days.ago.all_day).count
 end
 
end
