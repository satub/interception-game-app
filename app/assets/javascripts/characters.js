function Character(attributes)  {
  this.id = attributes.id;
  this.name = attributes.name;
  this.personality = attributes.personality;
  this.image = attributes.image_link;
  this.player_id = attributes.player_id;
  this.level = attributes.level;
}

Character.prototype.constructor = Character;

Character.prototype.renderChar = function(){
  debugger;
  // let content = $('<strong></strong>').text(this.content);
  // let defense = $('<strong></strong>').text(this.defense);
  // $("#hover_data").append(content, defense);
}

function fetchMyCharacters(){
  var charsUrl = "/players/" + playerId + "/characters";
  $.get(charsUrl).done(function(response){

    var chars = response.characters;

    debugger;
    for (var i = 0; i < chars.length; i++){
      var char = new Character(chars[i]);
    }
  });
}
