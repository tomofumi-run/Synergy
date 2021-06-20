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
//= require jquery.jscroll.min.js
//= require popper
//= require bootstrap
//= require summernote/summernote-bs4.min
//= require summernote-init
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree

document.addEventListener("turbolinks:load",function () {
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

//logoの表示
$(window).on('turbolinks:load',function(){
  $("#splash").delay(1500).fadeOut('slow');
  $("#splash_logo").delay(1000).fadeOut('slow');
});



$(document).on('turbolinks:load', function() {
  $('.jscroll').jscroll({
    nextSelector: 'a[rel=next].page-link',
    contentSelector: '.jscroll',
  });
});
