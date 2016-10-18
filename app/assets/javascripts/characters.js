function fetchMyCharacters(){
  var charUrl = "/players/" + playerId + "/characters";
  $.get(charUrl).done(function(response){
    debugger;
  });
}
