function fetchGames(){
  eraseStatusBox();
  $.get("/games").done(function(response){
    debugger;
  });
}
