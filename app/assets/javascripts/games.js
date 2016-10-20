function Game(attributes){
  this.title = attributes.title;
  this.id = attributes.id;
  this.turn= attributes.turn;
  this.winner = attributes.winner;
  this.status = attributes.status;
  this.map_name = attributes.map_name;
  this.map_size = attributes.map_size;
  this.background = attributes.background_image_link;
  this.locations = attributes.locations;
}

Game.prototype.constructor = Game;

Game.prototype.joinable = function(){
  return this.status === "pending";
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

  //// Reload the link in the status box
  $("#shortcut")[0].innerHTML = '<a href="/games/' + game.id + '">Current game: ' + game.title + '</a>';

  ///Reattach event listener....maybe move this elsewhere....
  $("#shortcut a:contains('Current game')").bind("click", function(event){
    defaultStopper(event);
    fetchGameViaUrl(event.currentTarget.href);
  });

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
}

function fetchGameViaUrl(gameUrl){
  $.get(gameUrl).done(function(response){
    loadGame(response);
  });
}

function fetchGame(gameId){
  var gameUrl = "/games/" + gameId;
  fetchGameViaUrl(gameUrl);
}

function addGameListListeners(){
  $('div[data-gameid]').bind("click", function(event){
    defaultStopper(event);
    var gameId = $(this).attr('data-gameid');
    fetchGame(gameId);
  });
}

function fetchGames(){
  $.get("/games").done(function(response){
    gamesToHTML(response);
    addGameListListeners();
  });
}
