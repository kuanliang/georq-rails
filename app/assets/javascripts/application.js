// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require bootstrap
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require jquery-ui/datepicker
//= require jquery-ui-timepicker-addon
//= require jquery_nested_form
//= require bootstrap/dropdown
//= require bootstrap/alert
//= require_tree .


//= require_tree 
var opt={
   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
   dayNamesMin:["日","一","二","三","四","五","六"],
   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
   prevText:"上月",
   nextText:"次月",
   weekHeader:"週",
   showMonthAfterYear:true,
   dateFormat:"yy-mm-dd"
   };
$(document).on("page:load ready", function(opt){
    $("input.datepicker").datepicker({
    dateFormat: "yy-mm-dd",
    altField: $(this).next()
  });
});

$(document).on("page:load ready", function(opt){
    $("input.datepicker2").datepicker({
    dateFormat: "mm-dd-yy",
    altField: $(this).next()
  });
});




function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}

