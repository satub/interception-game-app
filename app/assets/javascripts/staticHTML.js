function printRules(){
  $.get("/about").done(function(response){
    $('.status').html(response);
  })
}

function eraseStatusBox(){
  $('.status').html('');
}

function eraseGameList(){
  $('#games').html('');
}

function eraseGame(){
  $('#currentGame').html('');
}

function removeForms(){
  $('#forms').html('');
}
