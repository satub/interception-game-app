function Location(attributes){
  this.content = attributes.content;
  this.id = attributes.id;
  this.controlled_by = attributes.controlled_by;
  this.history = attributes.character_locations;
  this.defense = attributes.defense;
}

Location.prototype.constructor = Location;

Location.prototype.renderOwned = function(){
  debugger;
}

Location.prototype.renderNotOwned = function(){
  debugger;
}

Location.prototype.renderHistory = function(){
  debugger;
}

function showLocationStatus(loc){
    let content = $('<strong></strong>').text(loc.content);
    let defense = $('<strong></strong>').text(loc.defense);
    $("#hover_data").append(content, defense);
}

function fetchLocation(gameId, locationId){
  var locationUrl = "/games/" + gameId + "/locations/" + locationId;
  $.get(locationUrl).done(function(response){
    var loc = new Location(response.location);
    showLocationStatus(response.location);
    Location(response.location);
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
