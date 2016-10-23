//// This is the first JS file to be loaded.

var playerId;
var playerAlias;
var turn;

function defaultStopper(event){
  event.preventDefault();
  event.stopPropagation();
}

function hideAbout(){
  $('#about').hide();
}
function showAbout(){
  $('#about').show();
}

function printRules(){
  $.get("/about").done(function(response){
    $('#about').html(response);
    showAbout();
  })
}

function hideGame(){
  $('#currentGame').hide();
}
function showGame(){
  $('#currentGame').show();
}
function hideGames(){
  $('#games').hide();
}
function showGames(){
  $('#games').show();
}
function hideCharacters(){
  $('#characters').hide();
}
function hideHistory(){
  $('#history').hide();
}
function hideForms(){
  $('#forms').hide();
}
function showCharacters(){
  $('#characters').show();
}
function showHistory(){
  $('#history').show();
}
function showForms(){
  $('#forms').show();
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
  $('#alias').html('Logged in as: ' + playerAlias);
}

function loggedIn(){
  return !!playerId;
}

function cleanScreen(){
  eraseGameList();
  eraseGame();
  removeForms();
  hideAbout();
  eraseCharacterList();
  removeHover();
  $("body").css('background', '0');
}

function hideLayout(){
  hideAbout();
  removeHover();
  hideGame();
  hideGames();
  hideForms();
  hideCharacters();
  hideHistory();
}

function myTurn(){
  return turn === playerId;
}

function showTurn(){
  if (myTurn()){
    $('#turn').html('Make your Move');
  } else {
    $('#turn').html('Waiting for turn...');
  }
}



/////This needs serious refactoring
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


          //this needs to be abstracted  and / or moved to a separate method!!!
      if (resource === "games"){
        $.post(formUrl, params).done(function(response){
          removeForms();
          var g = new Game(response.game);
          g.renderGame();
          showGame();
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
