function printRules(){
  $.get("/about").done(function(response){
    $('.status').html(response);
  })
}
