//// This is the first JS file to be loaded.

var playerId;
var playerAlias;
var turn;

function defaultStopper(event){
  event.preventDefault();
  event.stopPropagation();
}

function printRules(){
  $.get("/about").done(function(response){
    $('#about').html(response);
  })
}

function eraseAbout(){
  $('#about').html('');
}

function eraseGameList(){
  $('#games').html('');
}

function eraseGame(){
  $('#currentGame').html('');
}

function eraseCharacterList(){
  $('#characters').html('');
}

function removeForms(){
  $('#forms').html('');
}

function removeHover(){
  $("#hover_data").html("");
}

function showPlayer(){
  $('#status').append('Logged in as: ' + playerAlias);
}

function loggedIn(){
  return !!playerId;
}

function cleanScreen(){
  eraseGameList();
  eraseGame();
  removeForms();
  eraseAbout();
  eraseCharacterList();
  removeHover();
}

function showTurn(){
  if (turn == playerId){
    $('#status').append('Make your Move');
  } else {
    $('#status').append('Waiting for turn...');
  }
}

function generateNewForm(resource){  ///currently also creates the resource!! :O
  removeForms();
  var resourceUrl = "/" + resource + "/new"
  $('#forms').html('Generate a new form here');
  $.get(resourceUrl).done(function(response){
    $('#forms').html(response);

    if($("#gameFull")){
      var startUrl = ('#shortcut a')[0].href + '/start';


      var launchButton = $('<button/>').text('Launch Game!');
      $('#currentGame').append(launchButton);
      $('#currentGame button').bind("click", function (event){
        defaultStopper(event);
        var startUrl = $('#shortcut a')[0].href + '/start';

        var data =  {status: "active"}

        $.post(startUrl, data).done(function(response){
          cleanScreen();
          debugger;
          turn = response.game.turn;
          showTurn();
          ////add a message here and point to render game page!!
        });
      })
    }

    $('#forms form').on("submit", function(event){
      event.preventDefault();
      var $form = $(this);
      var formUrl = $form.attr("action");
      var params = $form.serialize();
      // var type = $form.attr("method");   //needed maybe later for other than post requests, commented out for now


          //this needs to be abstracted  and / or moved to a separate method!!!
      if (resource === "games"){
        $.post(formUrl, params).done(function(response){
          removeForms();
          debugger;
          loadGame(response);
        }).fail(function (error){
          var failures = JSON.parse(error.responseText);

          $('#game_title').attr("placeholder", failures["title"][0]).css("border","2px solid red");
          $('#game_map_size').attr("placeholder", failures["map_size"][0]).css("border","2px solid red");
        });
      } else {
        ///For now, character assignment to a game needs a different method
        params = $form.serializeArray();
        $.post(formUrl, params).done(function(response){
          removeForms();
          var char = new Character(response.character);
          if (char.id){
            char.renderChar();
          }
        }).fail(function (error){
          var failures = JSON.parse(error.responseText);

          $('#character_name').attr("placeholder", failures["name"][0]).css("border","2px solid red");
        });

        //// Render message or error to screen and launch game if ready!
      }



    });
  });
}