function showLocationStatus(loc){
    let content = $('<strong></strong>').text(loc.content);
    let defense = $('<strong></strong>').text(loc.defense);
    $("#hover_data").append(content, defense);
}

function fetchLocation(gameId, locationId){
  var locationUrl = "/games/" + gameId + "/locations/" + locationId;
  $.get(locationUrl).done(function(response){
    showLocationStatus(response.location);
  });
}

function addLocationTakeOverListeners(gameId){
  $('div.location').bind("click", function(event){
    defaultStopper(event);
    var locationId = $(this).attr('data-locationid');
    console.log("'That would be intimidating, if you were, well, intimidating.. '");
    fetchLocation(gameId, locationId);
  });
}


/// Hopefully can be added without revealing too much information :P
function showInfo(){

}
