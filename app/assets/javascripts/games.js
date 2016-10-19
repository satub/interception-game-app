function resetCurrentGame(gameId){
 //this should go and set the player's current game to this game --- IF needed
  console.log("In ur machina, resettin' ur dreams...");
}

function gamesToHTML(gamesAsJSON){
  eraseGameList();
  var gameList = '<h5>List of Games</h5>';
  var allGames =  gamesAsJSON.games;
  for (var i = 0; i < allGames.length; i++){
    gameList += '<div data-gameid="' + allGames[i].id + '" class="' + allGames[i].status + '">';
    gameList += allGames[i].title + ' at ' + allGames[i].map_name + '; Map Size: ' + allGames[i].map_size;
    if (allGames[i].winner){
      gameList += 'Winner: ' + allGames[i].winner;
    }
    gameList += '</div>';
  }
  $('#games').html(gameList);
}

function loadGame(gameAsJSON){
  eraseGame();
  let game = gameAsJSON.game;
  let gameTitle = $('<h3></h3>').text(game.title);
  let map = $('<div id="map"></div>');
  $("#currentGame").append(gameTitle,map);

  let mapName = $('<h4></h4>').text(game.map_name);
  $('#map').append(mapName);

  game.locations.forEach(function(loc){
    let location = $('<div class="location" data-locationid="' + loc.id + '"></div>').text(loc.controlled_by);
    $('#map').append(location);
  });

  $("#currentGame").append('<br><br>'); ///Replace this later with better div styling!!


  addLocationTakeOverListeners(game.id);

  $('div.location').mouseenter(function(event){
    var locationId = $(this).attr('data-locationid');
    defaultStopper(event);
    fetchLocation(game.id, locationId);
    $("#hover_data").css( {position:"absolute", top:event.pageY, left: event.pageX});
  });

  $('div.location').mouseleave(function(event){
    defaultStopper(event);
    $("#hover_data").html('');
  });

  resetCurrentGame(game.id);  //this should go and set the player's current game to this game IF we still need this feature..
}

function fetchGame(gameId){
  var gameUrl = "/games/" + gameId
  $.get(gameUrl).done(function(response){
    loadGame(response);
  });
}

function addGameListListeners(){
  $('div[data-gameid]').bind("click", function(event){
    defaultStopper(event);
    var gameId = $(this).attr('data-gameid');
    ///assign current_game here;
    fetchGame(gameId);
  });
}

function fetchGames(){
  $.get("/games").done(function(response){
    gamesToHTML(response);
    addGameListListeners();
  });
}
