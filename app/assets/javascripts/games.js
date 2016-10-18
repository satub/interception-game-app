function objectifyGames(gamesAsJSON){
  console.log("Don't objectify us, it's not nice! D: ");
}

function gamesToHTML(gamesAsJSON){
  // debugger;
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
  // $('#games').html(JSON.stringify(gamesAsJSON)); ///for test data dumping only
  $('#games').html(gameList);
}

function loadGame(){
  debugger;
}

function fetchGame(gameId){
  var gameUrl = "/games/" + gameId
  $.get(gameUrl).done(function(response){
    loadGame();
  });
}

function addGameListListeners(){
  $('div[data-gameid]').bind("click", function(event){
    event.preventDefault();
    event.stopPropagation();
    var gameId = $(this).attr('data-gameid');
    fetchGame(gameId);
  });
}

function fetchGames(){
  $.get("/games").done(function(response){
    objectifyGames(response);
    gamesToHTML(response);
    addGameListListeners();
  });
}
