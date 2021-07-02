class Admin::ChartsController < ApplicationController
 before_action :authenticate_admin!
 
 def post_chart
    posts = Post.all
    @today_post = posts.where(created_at: Date.today.all_day).count
    @yesterday_post = posts.chart_data(1)
    @two_days_ago_post = posts.chart_data(2)
    @three_days_ago_post = posts.chart_data(3)
    @four_days_ago_post = posts.chart_data(4)
    @five_days_ago_post = posts.chart_data(5)
    @six_days_ago_post = posts.chart_data(6)
    @one_week_ago_post = posts.chart_data(7)
 end
end
