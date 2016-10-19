function defaultStopper(event){
  event.preventDefault();
  event.stopPropagation();
}

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

function generateNewForm(resource){  ///currently also creates the resource!! :O
  removeForms();
  var resourceUrl = "/" + resource + "/new"
  $('#forms').html('Generate a new form here');
  $.get(resourceUrl).done(function(response){
    $('#forms').html(response);

    $('#forms form').on("submit", function(event){
      event.preventDefault();
      var $form = $(this);
      var formUrl = $form.attr("action");
      var params = $form.serialize();
      // var type = $form.attr("method");   //needed maybe later for other than post requests, commented out for now

      $.post(formUrl, params).done(function(response){
        removeForms();
        debugger;
        loadGame(response);
      }).fail(function (error){
        var failures = JSON.parse(error.responseText);
        debugger;
        //this needs to be abstracted
        $('#game_title').attr("placeholder", failures["title"][0]).css("border","2px solid red");
        $('#game_map_size').attr("placeholder", failures["map_size"][0]).css("border","2px solid red");
      });
    });
  });
}
