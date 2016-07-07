

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