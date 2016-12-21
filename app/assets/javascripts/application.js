// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require mediaelement_rails
//= require_tree .
//= require bootstrap-datepicker

$(document).ready(function(){
  $('form[name=album-form]').on("submit", function(){
    $(".singer_id").val($('#album_artist_id').val());
  });

  var player = new MediaElementPlayer('#audio-player');

  $('.song-link').on("click", function(){
    player.setSrc($(this).attr('source'));
    player.load();
    player.play();
    return false;
  });
});
