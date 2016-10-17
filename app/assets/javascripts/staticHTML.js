function printRules(){
  $.get("/about").done(function(response){
    $('.status').html(response);
  })
}

function eraseStatusBox(){
  $('.status').html('');
}
