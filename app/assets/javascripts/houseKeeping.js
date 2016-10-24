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

function showKey(){
  var key = 'Color Key:<ul>';
  key += '<li class = "active">Active game</li>';
  key += '<li class = "pending">Waiting for more players</li>';
  key += '<li class = "finished">This game has finished</li></ul>'

  $('#about').html(key);
  showAbout();
}

function mapKey(){
  var key = 'Color Key:<ul>';
  key += '<div class = "notOwned">You do not control this location</div>';
  $('#about').html(key);
  showAbout();
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
  $('#alias').html('Logged in as: ' + playerAlias + '; Your player id is ' + playerId);
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

function instruction(){
  $('#turn').html('To assign characters to this game: Fill the form for "New Character"');
}


///// This form generator is for adding new entries to the DB, namely New Characters and games
///// It might make sense to split this up and move it to characters.js and games.js, unless it can be abstracted
///// Form for location takeovers is in locations.js
///// This STILL needs serious refactoring
function generateNewForm(resource){  ///currently also creates the resource!! :O
  removeForms();
  var resourceUrl = "/" + resource + "/new"

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
          hideForms();
          var g = new Game(response.game);
          g.renderGame();
          g.setBackground();
          g.setShortcut();
          showGame();
          instruction();
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
          hideForms();
          var char = new Character(response.character);
          if (char.id){
            char.renderChar();
          }
          showCharacters();
        }).fail(function (error){
          var failures = JSON.parse(error.responseText);

          $('#character_name').attr("placeholder", failures["name"][0]).css("border","2px solid red");
        });

      }



    });
  });
}
