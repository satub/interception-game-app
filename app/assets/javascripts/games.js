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

Game.prototype.renderGame = function(){
  eraseGame();

  let gameTitle = $('<div id = "title"></div>').text(this.title);

  let map = $('<div id = "map"></div>');

  $("#currentGame").append(gameTitle,map);

  let mapName = $('<div id = "mapName"></div>').text(this.map_name);
  $('#map').append(mapName);

  this.locations.forEach(function(loc){
    let location = $('<div class="location" data-locationid="' + loc.id + '"></div>').text(loc.controlled_by);
    $('#map').append(location);
  });

  $("#currentGame").append('<br><br>'); ///Replace this later with better div styling!!

  if(this.background){
    ///Call setStyle function if these parameters were given:
    $("body").css("background-image",'url("' + this.background + '")');
  }

  //// Reload the link in the status box
  $("#shortcut")[0].innerHTML = '<a href="/games/' + this.id + '">Current game: ' + this.title + '</a>';

  ///Reattach event listener....maybe move this elsewhere....
  $("#shortcut a:contains('Current game')").bind("click", function(event){
    defaultStopper(event);
    fetchGameViaUrl(event.currentTarget.href);
  });

  ///attach LocationTakeOverListeners;
  var gameId = this.id;
  addLocationTakeOverListeners(gameId);

  $('div.location').mouseenter(function(event){
    var locationId = $(this).attr('data-locationid');
    defaultStopper(event);
    fetchLocation(gameId, locationId);
    $("#hover_data").css( {position:"absolute", top:event.pageY, left: event.pageX});
  });

  $('div.location').mouseleave(function(event){
    defaultStopper(event);
    $("#hover_data").html('');
  });

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


function fetchGameViaUrl(gameUrl){
  $.get(gameUrl).done(function(response){
    var g = new Game(response.game);
    g.renderGame();
    if (g.joinable()){


      var joinButton = $('<button/>').text('Join Game!');
      $('#currentGame').append(joinButton);

      $('#currentGame button').bind("click", function (event){
        defaultStopper(event);
        var joinUrl = '/games/' + g.id + '/join';
        $.get(joinUrl).done(function(response){
          cleanScreen();
          generateNewForm('players/' + playerId + '/characters');
        });
      })
    }
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
