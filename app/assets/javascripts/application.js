// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require bootstrap-slider
//= require autocomplete-rails
//= require turbolinks
//= require cocoon
//= require_tree .

var ready;
ready = function() {
    if($('.wrap').height()<$(window).height()){
        $(".footer").css({"position":"fixed", "bottom":"0"});
    }

    if($(".message").hasClass("in")){
        setTimeout(function(){
            $(".message").modal("hide")
        }, 3000);
    }
};

$(document).ready(ready);
$(document).on('page:load', ready);
