// ES6 Class example
// class Game {
//   constructor(attributes){
//     this.title = attributes.title;
//     this.id = attributes.id;
//     this.turn= attributes.turn;
//     this.winner = attributes.winner;
//     this.status = attributes.status;
//     this.map_name = attributes.map_name;
//     this.map_size = attributes.map_size;
//     this.background = attributes.background_image_link;
//     this.locations = attributes.locations;
//     this.players = attributes.game_players;
//   }
//   joinable(){
//       return this.status === "pending";
//   }
//
// }

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
  this.players = attributes.game_players;
}

// Game.prototype.constructor = Game;

Game.prototype.joinable = function(){
  return this.status === "pending";
}

Game.prototype.notInYet = function(){
  var gamePlayers = this.players.map(function(player){
    return player.player_id
  });
  return gamePlayers.indexOf(playerId) === -1;
}

Game.prototype.launchable = function(){
  return (this.players.length > 1 && !this.notInYet() && this.status === "pending");
}

Game.prototype.setBackground = function(){
  if(this.background){
    $("body").css("background-image",'url("' + this.background + '")');
  } else {
    $("body").css('background', '0');
  }
}

Game.prototype.setShortcut = function(){
  $("#shortcut")[0].innerHTML = '<a href="/games/' + this.id + '">Current game: ' + this.title + '</a>';

  ///Reattach event listener to the shortcut
  $("#shortcut a:contains('Current game')").bind("click", function(event){
    defaultStopper(event);
    fetchGameViaUrl(event.currentTarget.href);
  });
}


Game.prototype.showLocation = function(locationId){
  let loc = this.locations[locationId];

  if (loc.controlled_by === playerId){
    loc.renderOwned();
  } else {
    loc.renderNotOwned();
  }

}

Game.prototype.renderGame = function(){
  eraseGame();
  turn = this.turn;
  showTurn();
  let map = $('<div id = "map" class="col-9 clearfix rounded"></div>');

  $("#currentGame").append(map);

  let mapName = $('<div id = "mapName" class="center"></div>').text("Map: " + this.map_name);
  $('#map').append(mapName);

  this.locations.forEach(function(loc){
    let location = $('<div class="col col-2 mx-auto p1 border-box border rounded location" data-locationid="' + loc.id + '"></div>').text(loc.controlled_by);
    if (playerId != loc.controlled_by){
      location.addClass("notOwned");
    } else {
      location.removeClass("notOwned");
    }
    $('#map').append(location);
  });

  var gameId = this.id;
  addLocationTakeOverListeners(gameId);

  $('div.location').mouseenter(function(event){
    var locationId = $(this).attr('data-locationid');
    defaultStopper(event);
    // showLocation(locationId);
    fetchLocation(gameId, locationId);
    $("#hover_data").css( {position:"absolute", top:event.pageY, left: event.pageX});
  });

  $('div.location').mouseleave(function(event){
    defaultStopper(event);
    $("#hover_data").html('');
  });
  mapKey();
}

Game.prototype.addJoinFunction = function(){
  var joinUrl = '/games/' + this.id + '/join';

  $('#turn').html("Join This Game");

  $('#turn:contains("Join This Game")').bind("click", function (event){
    defaultStopper(event);

    $.get(joinUrl).done(function(response){
      removeForms();
      generateNewForm('players/' + playerId + '/characters');
      showForms();
      instruction();
    });
  })

}

Game.prototype.addLaunchFunction = function(){
  var startUrl = '/games/' + this.id + '/start';

  $('#turn').html("Launch Game!");

  $('#turn:contains("Launch Game!")').bind("click", function (event){
    defaultStopper(event);
    var data =  {status: "active"}
    $.post(startUrl, data).done(function(response){
      // cleanScreen();
      turn = response.game.turn;
      showTurn();

      ////add a message here and point to render game page!!
    });
  });
}


function gamesToHTML(gamesAsJSON){
  eraseGameList();
  var gameList = 'List of Games<ul>';
  var allGames =  gamesAsJSON.games;
  for (var i = 0; i < allGames.length; i++){
    gameList += '<li data-gameid="' + allGames[i].id + '" class="' + allGames[i].status + '">';
    gameList += allGames[i].title + ' at ' + allGames[i].map_name + '; Map Size: ' + allGames[i].map_size;
    if (allGames[i].winner){
      gameList += 'Winner: ' + allGames[i].winner;
    }
    gameList += '</li>';
  }
  gameList += '</ul>';
  $('#games').html(gameList);
  showGames();
  showKey();
}


function fetchGameViaUrl(gameUrl){
  $.get(gameUrl).done(function(response){

    var g = new Game(response.game);
    g.renderGame();
    g.setBackground();
    g.setShortcut();

    if (g.joinable() && g.notInYet()){
      g.addJoinFunction();
    } else if (g.launchable()){
      g.addLaunchFunction();
    }
  });
}


function fetchGame(gameId){
  var gameUrl = "/games/" + gameId;
  fetchGameViaUrl(gameUrl);
}

function addGameListListeners(){
  $('li[data-gameid]').bind("click", function(event){
    defaultStopper(event);
    var gameId = $(this).attr('data-gameid');
    fetchGame(gameId);
    showGame();
    hideAbout();
  });
}

function fetchGames(){
  $.get("/games").done(function(response){
    gamesToHTML(response);
    addGameListListeners();
  });
}
