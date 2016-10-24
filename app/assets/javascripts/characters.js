function Character(attributes)  {

  this.id = attributes.id;
  this.name = attributes.name;
  this.personality = attributes.personality;
  this.image = attributes.image_link;
  if (this.player){
    this.ownerId = attributes.player.id;
    this.ownerAlias = attributes.player.alias;
  }
  this.gameStats = attributes.game_characters;
  this.level = attributes.level;
}

Character.prototype.constructor = Character;

Character.prototype.renderChar = function(){
  let div = $('<div data-characterId="' + this.id + '"></div>');
  let img = $('<img />',
             { src: this.image,
               width: 250
             });
  let personality = $('<p></p>').text("Personality: " + this.personality);
  let name = $('<p></p>').html('<strong>' + this.name + '</strong>');
  let stats = this.gameStats;
  let troopsLeft = $('<p></p>').text("Character not in use in this game.");
  for(var j=0; j<stats.length; j++){
    if (stats[j].game_id == $("a:contains('Current game')")[0].href.match(/\d+$/)[0]){
      troopsLeft = $('<p></p>').text("Troops: " + stats[j].troops);
      break;
    }
  }
  div.append(name, img, personality, troopsLeft);
  $("#characters").append(div);
}


function fetchMyCharacters(){
  eraseCharacterList();
  var charsUrl = "/players/" + playerId + "/characters";
  $.get(charsUrl).done(function(response){
    var chars = response.characters;
    for (var i = 0; i < chars.length; i++){
      var char = new Character(chars[i]);
      char.renderChar();
    }
  });
}
