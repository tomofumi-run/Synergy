// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.

//= require jquery3
//= require jquery
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap
//= require summernote/summernote-bs4.min
//= require summernote-init
//
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree

// 無限スクロール
$(document).ready(function() {
  $('.jscroll').jscroll({
    nextSelector: 'a[rel=next].page-link',
    contentSelector: '.jscroll',
  });
  $(".theTarget").skippr({
    transition : 'slide',
    speed : 2000,
    easing : 'easeOutQuart',
    navType : 'block',
    childrenElementType : 'div',
    arrows : true,
    autoPlay : true,
    autoPlayDuration : 5000,
    keyboardOnAlways : true,
    hidePrevious : false
  });
});

//ロゴ表示
$(window).ready(function(){
  $("#splash").delay(1500).fadeOut('slow');
  $("#splash_logo").delay(1000).fadeOut('slow');
});


// ページトップへの遷移
$(document).ready(function(){
  let pagetop = $('#page_top');
  pagetop.hide();
  $(window).scroll(function () {
     if ($(this).scrollTop() > 1000) {
          pagetop.fadeIn();
     } else {
          pagetop.fadeOut();
     }
  });
  pagetop.click(function () {
     $('body, html').animate({ scrollTop: 0 }, 1000);
     return false;
  });
});

// サクセスアラートのフェードアウト
$(function(){
  $(".alert-success").fadeOut(5000);
});